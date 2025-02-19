import 'dart:convert';
import 'package:dandaily/config/colors_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DashboardPage extends NyStatefulWidget {
  static RouteView path = ("/dashboard", (context) => DashboardPage());

  DashboardPage({super.key}) : super(child: () => _DashboardPageState());
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selectToDate();
      loadTodos();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Map<String, dynamic>> todos = [];
  final ScrollController _scrollController = ScrollController();
  DateTime selectedDate = DateTime.now();
  DateTime displayedMonth = DateTime.now();
  int selectedStatus = 0;
  String? selectedPriority;

  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosJson = prefs.getString('todos');
    if (todosJson != null) {
      setState(() {
        todos = List<Map<String, dynamic>>.from(jsonDecode(todosJson));
      });
    }
  }

  final List<Map<String, dynamic>> labelsList = [
    {
      'title': 'Study',
      'icon': Icons.book,
      'color': SetColors.primaryColor,
    },
    {
      'title': 'Sport',
      'icon': Icons.sports,
      'color': SetColors.skyColor,
    },
    {
      'title': 'Work',
      'icon': Icons.work,
      'color': SetColors.taroColor,
    },
    {
      'title': 'Habit',
      'icon': Icons.repeat,
      'color': SetColors.caramelColor,
    },
  ];

  Map<String, int> _getProgressCounts() {
    final filteredTodos = _getFilteredTodos();
    Map<String, int> counts = {
      'Open': 0,
      'Doing': 0,
      'Done': 0,
      'Late': 0,
    };

    for (var todo in filteredTodos) {
      String status = todo['status']?.toString().trim() ?? '';
      if (counts.containsKey(status)) {
        counts[status] = counts[status]! + 1;
      }
    }

    return counts;
  }

  List<DateTime> _getDaysInMonth() {
    final DateTime firstDayOfMonth =
        DateTime(displayedMonth.year, displayedMonth.month, 1);
    final DateTime lastDayOfMonth =
        DateTime(displayedMonth.year, displayedMonth.month + 1, 0);
    List<DateTime> days = [];

    for (DateTime day = firstDayOfMonth;
        day.isBefore(lastDayOfMonth.add(const Duration(days: 1)));
        day = day.add(const Duration(days: 1))) {
      days.add(day);
    }

    return days;
  }

  List<Map<String, dynamic>> _getFilteredTodos() {
    var filteredByDate = todos.where((todo) {
      if (todo['startDate'] == null) return false;

      final todoStartDate = DateTime.parse(todo['startDate']);
      final todoEndDate = todo['endDate'] != null
          ? DateTime.parse(todo['endDate'])
          : todoStartDate;

      final selectedDateTime =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
      final startDateTime =
          DateTime(todoStartDate.year, todoStartDate.month, todoStartDate.day);
      final endDateTime =
          DateTime(todoEndDate.year, todoEndDate.month, todoEndDate.day);

      return !selectedDateTime.isBefore(startDateTime) &&
          !selectedDateTime.isAfter(endDateTime);
    }).toList();

    // Add priority filter
    if (selectedPriority != null) {
      filteredByDate = filteredByDate
          .where((todo) => todo['priority'] == selectedPriority)
          .toList();
    }

    return filteredByDate;
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }

  void _previousMonth() {
    setState(() {
      displayedMonth = DateTime(displayedMonth.year, displayedMonth.month - 1);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        selectToDate();
      });
    });
  }

  void _nextMonth() {
    setState(() {
      displayedMonth = DateTime(displayedMonth.year, displayedMonth.month + 1);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        selectToDate();
      });
    });
  }

  void selectToDate() {
    DateTime now = DateTime.now();
    int targetDay;

    if (displayedMonth.year == now.year && displayedMonth.month == now.month) {
      targetDay = now.day;
    } else {
      targetDay = 1;
    }

    setState(() {
      selectedDate =
          DateTime(displayedMonth.year, displayedMonth.month, targetDay);
    });

    int targetIndex = targetDay - 1;
    double scrollPosition = targetIndex * 79.0;

    _scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void _deleteTodoItem(int index) {
    setState(() {
      todos.removeAt(index);
      _saveTodos();
    });
  }

  Color _getStatusIndicatorColor(String status) {
    switch (status) {
      case 'Open':
        return SetColors.skyColor;
      case 'Doing':
        return SetColors.caramelColor;
      case 'Done':
        return SetColors.primaryColor;
      case 'Late':
        return SetColors.redColor;
      default:
        return SetColors.textColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return SetColors.accentColor;
      case 'medium':
        return SetColors.accentColor;
      case 'low':
        return SetColors.accentColor;
      default:
        return SetColors.accentColor;
    }
  }

  Color _getPriorityFilterColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return SetColors.primaryColor;
      case 'medium':
        return SetColors.primaryColor;
      case 'low':
        return SetColors.primaryColor;
      default:
        return SetColors.primaryColor;
    }
  }

  IconData _getLabelIcon(String label) {
    switch (label.toLowerCase()) {
      case 'study':
        return Icons.book;
      case 'sport':
        return Icons.sports;
      case 'work':
        return Icons.work;
      case 'habit':
        return Icons.repeat;
      default:
        return Icons.label;
    }
  }

  Color _getLabelColor(String label) {
    switch (label.toLowerCase()) {
      case 'study':
        return SetColors.primaryColor;
      case 'sport':
        return SetColors.skyColor;
      case 'work':
        return SetColors.taroColor;
      case 'habit':
        return SetColors.caramelColor;
      default:
        return SetColors.accentColor;
    }
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('todos', jsonEncode(todos));
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SlidingUpPanel(
            maxHeight: size.height * 0.37,
            minHeight: size.height * 0.11,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
            color: SetColors.primaryColor,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.00),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: SetColors.accentColor,
                              ),
                            ),
                            Text(
                              "Let's complete your tasks!",
                              style: TextStyle(
                                fontSize: 18,
                                color: SetColors.textColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 9),

                  // Calendar Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              onPressed: _previousMonth,
                            ),
                            Text(
                              '${_getMonthName(displayedMonth.month)} ${displayedMonth.year}',
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2F4F4F),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed: _nextMonth,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: days.length,
                            clipBehavior: Clip.none,
                            itemBuilder: (context, index) {
                              final date = days[index];
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => selectedDate = date),
                                child: Container(
                                  width: 75,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    color: selectedDate.day == date.day &&
                                            selectedDate.month == date.month &&
                                            selectedDate.year == date.year
                                        ? SetColors.primaryColor
                                        : SetColors.milkyColor,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: SetColors.shadowColor,
                                        blurRadius: 0,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        [
                                          'Mo',
                                          'Tu',
                                          'We',
                                          'Th',
                                          'Fr',
                                          'Sa',
                                          'Su'
                                        ][date.weekday - 1],
                                        style: TextStyle(
                                          color: selectedDate.day == date.day &&
                                                  selectedDate.month ==
                                                      date.month &&
                                                  selectedDate.year == date.year
                                              ? SetColors.milkyColor
                                              : SetColors.primaryColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        '${date.day}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: selectedDate.day == date.day &&
                                                  selectedDate.month ==
                                                      date.month &&
                                                  selectedDate.year == date.year
                                              ? SetColors.milkyColor
                                              : SetColors.primaryColor,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Priority filtered
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 2),
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => selectedPriority = null),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 26, vertical: 8),
                            margin: const EdgeInsets.only(right: 9),
                            decoration: BoxDecoration(
                              color: selectedPriority == null
                                  ? SetColors.primaryColor
                                  : SetColors.milkyColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: SetColors.shadowColor,
                                  blurRadius: 0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              'All',
                              style: TextStyle(
                                color: selectedPriority == null
                                    ? SetColors.milkyColor
                                    : SetColors.accentColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        for (var priority in ['High', 'Medium', 'Low'])
                          GestureDetector(
                            onTap: () =>
                                setState(() => selectedPriority = priority),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 29, vertical: 8),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: selectedPriority == priority
                                    ? _getPriorityFilterColor(priority)
                                    : SetColors.milkyColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: SetColors.shadowColor,
                                    blurRadius: 0,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                priority,
                                style: TextStyle(
                                  color: selectedPriority == priority
                                      ? Colors.white
                                      : SetColors.accentColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Todo list
                  Expanded(
                    child: _getFilteredTodos().isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.task_outlined,
                                  size: 48,
                                  color: SetColors.primaryColor.withAlpha(5),
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  'No tasks for ${DateFormat('MMMM d, yyyy').format(selectedDate)}',
                                  style: TextStyle(
                                    color: SetColors.primaryColor.withAlpha(5),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(15),
                            itemCount: _getFilteredTodos().length,
                            itemBuilder: (context, index) {
                              final todo = _getFilteredTodos()[index];
                              final endDate = DateTime.parse(todo['endDate']);

                              return GestureDetector(
                                onTap: () async {
                                  final result = await Navigator.pushNamed(
                                    context,
                                    "/updatedtodo-detail",
                                    arguments: {
                                      ...todo,
                                      'index':
                                          index, // Pass the index to know which todo to update
                                    },
                                  );
                                  if (result != null &&
                                      result is Map<String, dynamic>) {
                                    setState(() {
                                      todos[index] = result;
                                      _saveTodos();
                                    });
                                  }
                                },
                                child: Dismissible(
                                  key: Key(todo['title']),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    _deleteTodoItem(index);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              '${todo['title']} dismissed')),
                                    );
                                  },
                                  background: Container(
                                    color: SetColors.secondaryColor,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: const Icon(Icons.delete,
                                        color: SetColors.redColor),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 14),
                                    decoration: BoxDecoration(
                                      color: SetColors.milkyColor,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: SetColors.shadowColor,
                                          blurRadius: 0,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        ListTile(
                                          horizontalTitleGap: 4,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 25, vertical: 8),

                                          //Status bullet
                                          leading: Container(
                                            width: 13,
                                            height: 13,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _getStatusIndicatorColor(
                                                  todo['status']),
                                            ),
                                          ),

                                          // Tasks title
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  todo['title'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        SetColors.accentColor,
                                                    decoration:
                                                        todo['status'] == 'Done'
                                                            ? TextDecoration
                                                                .lineThrough
                                                            : null,
                                                  ),
                                                ),
                                              ),

                                              //Tasks deadline
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons.calendar_today,
                                                        size: 10,
                                                        color:
                                                            Colors.grey[600]),
                                                    const SizedBox(width: 2),
                                                    Text(
                                                      DateFormat('dd MMM yyyy')
                                                          .format(endDate),
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                    if (todo['endTime'] !=
                                                        null) ...[
                                                      const SizedBox(width: 4),
                                                      Icon(Icons.access_time,
                                                          size: 10,
                                                          color:
                                                              Colors.grey[600]),
                                                      const SizedBox(width: 2),
                                                      Text(
                                                        todo['endTime'],
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 11,
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                          // Tasks description
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  todo['description'],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.grey[600],
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),

                                              // Tasks labels
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  color: _getLabelColor(
                                                          todo['label'])
                                                      .withAlpha(70),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Icon(
                                                  _getLabelIcon(todo['label']),
                                                  size: 18,
                                                  color: _getLabelColor(
                                                      todo['label']),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Tasks priority
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: _getPriorityColor(
                                                  todo['priority']),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                bottomRight:
                                                    Radius.circular(15),
                                              ),
                                            ),
                                            child: Text(
                                              todo['priority'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            panelBuilder: (controller) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Panel handle
                    Center(
                      child: Container(
                        width: 100,
                        height: 3,
                        decoration: const BoxDecoration(
                          color: SetColors.secondaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Labels Section
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Progress today',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: SetColors.milkyColor,
                              ),
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 2.9,
                            ),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              final statuses = [
                                'Open',
                                'Doing',
                                'Done',
                                'Late'
                              ];
                              final statusCounts = _getProgressCounts();
                              final status = statuses[index];
                              final count = statusCounts[status] ?? 0;

                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: SetColors.milkyColor,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: SetColors.shadowColor,
                                      blurRadius: 0,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 8),

                                    // Status indicator circle
                                    Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _getStatusIndicatorColor(status),
                                      ),
                                    ),
                                    const Spacer(),

                                    // Status title
                                    Text(
                                      status,
                                      style: const TextStyle(
                                        color: SetColors.accentColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Spacer(),

                                    // Count
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: SetColors.secondaryColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        count.toString(),
                                        style: const TextStyle(
                                          color: SetColors.accentColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // navbar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 65,
              padding: const EdgeInsets.only(top: 5, bottom: 13),
              decoration: const BoxDecoration(
                color: SetColors.secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: SetColors.shadowColor,
                    blurRadius: 0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.home_outlined,
                      size: 38,
                    ),
                    color: SetColors.accentColor,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_circle_rounded,
                      size: 40,
                    ),
                    color: SetColors.primaryColor,
                    onPressed: () async {
                      final result =
                          await Navigator.pushNamed(context, '/todo-create');
                      if (result != null && result is Map<String, dynamic>) {
                        setState(() {
                          todos.add(result);
                          _saveTodos();
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.settings_outlined,
                      size: 38,
                    ),
                    color: SetColors.primaryColor,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
