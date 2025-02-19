import 'package:dandaily/config/colors_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nylo_framework/nylo_framework.dart';

class UpdatedTodoDetailPage extends NyStatefulWidget {
  static RouteView path =
      ("/updatedtodo-detail", (_) => UpdatedTodoDetailPage());

  UpdatedTodoDetailPage({super.key})
      : super(child: () => _UpdatedTodoDetailPageState());
}

class _UpdatedTodoDetailPageState extends NyPage<UpdatedTodoDetailPage> {
  late Map<String, dynamic> updatedtodoData;
  late int updatedtodoIndex;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String status = 'Open';
  String priority = 'High';
  String label = 'Study';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get passed updatedtodo data
      final args = widget.data();
      updatedtodoData = args as Map<String, dynamic>;
      updatedtodoIndex = updatedtodoData['index'];

      // Initialize controllers and state variables
      titleController.text = updatedtodoData['title'];
      descriptionController.text = updatedtodoData['description'];

      if (updatedtodoData['startDate'] != null) {
        startDate = DateTime.parse(updatedtodoData['startDate']);
      }
      if (updatedtodoData['endDate'] != null) {
        endDate = DateTime.parse(updatedtodoData['endDate']);
      }

      if (updatedtodoData['startTime'] != null) {
        final timeParts = updatedtodoData['startTime'].split(':');
        startTime = TimeOfDay(
            hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));
      }
      if (updatedtodoData['endTime'] != null) {
        final timeParts = updatedtodoData['endTime'].split(':');
        endTime = TimeOfDay(
            hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));
      }

      status = updatedtodoData['status'];
      priority = updatedtodoData['priority'];
      label = updatedtodoData['label'];

      setState(() {});
    });
  }

  Future<void> _selectDate(bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate : endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
          if (startDate!.isAfter(endDate!)) {
            endDate = startDate;
          }
        } else {
          endDate = picked;
          if (endDate!.isBefore(startDate!)) {
            startDate = endDate;
          }
        }
      });
    }
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      backgroundColor: SetColors.milkyColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Edit Tasks',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D5A54),
                          ),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.close, color: Color(0xFF9BA3C2)),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(
                      label: 'TITLE',
                      controller: titleController,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'DESCRIPTION',
                      controller: descriptionController,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDateField(
                            label: 'START DATE',
                            value: startDate,
                            onTap: () => _selectDate(true),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildDateField(
                            label: 'END DATE',
                            value: endDate,
                            onTap: () => _selectDate(false),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTimeField(
                            label: 'START TIME',
                            value: startTime,
                            onTap: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                setState(() => startTime = time);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTimeField(
                            label: 'END TIME',
                            value: endTime,
                            onTap: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                setState(() => endTime = time);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildStatusSection(),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdown(
                            label: 'PRIORITY',
                            value: priority,
                            items: const ['High', 'Medium', 'Low'],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => priority = value);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildDropdown(
                            label: 'LABELS',
                            value: label,
                            items: const ['Study', 'Work', 'Sport', 'Habit'],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => label = value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SetColors.primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 11, horizontal: 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Edit Tasks',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    // required bool Function(String) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF7BA89B),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F9F7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: NyTextField.compact(
            controller: controller,
            validationRules: "not_empty|max:50",
            cursorColor: SetColors.primaryColor,
            backgroundColor: SetColors.primaryColor.withAlpha(10),
            style: const TextStyle(
              fontSize: 14,
              color: SetColors.accentColor,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: SetColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F9F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: Color(0xFF7BA89B),
                  size: 15,
                ),
                const SizedBox(width: 8),
                Text(
                  value != null
                      ? DateFormat('yyyy-MM-dd').format(value)
                      : 'Select date',
                  style: const TextStyle(
                    color: SetColors.accentColor,
                    fontSize: 14,
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Color(0xFF7BA89B)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField({
    required String label,
    required TimeOfDay? value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF7BA89B),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F9F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.alarm_add,
                  color: Color(0xFF7BA89B),
                  size: 15,
                ),
                const SizedBox(width: 5),
                Text(
                  value?.format(context) ?? 'Select time',
                  style: const TextStyle(
                    color: SetColors.accentColor,
                    fontSize: 14,
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: Color(0xFF7BA89B)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'STATUS',
          style: TextStyle(
            color: Color(0xFF7BA89B),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildStatusOption('Open', SetColors.skyColor.withAlpha(70),
                SetColors.accentColor),
            const SizedBox(width: 16),
            _buildStatusOption('Doing', SetColors.caramelColor.withAlpha(70),
                SetColors.accentColor),
            const SizedBox(width: 16),
            _buildStatusOption('Done', SetColors.primaryColor.withAlpha(70),
                SetColors.accentColor),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusOption(String text, Color color, Color textColor) {
    final isSelected = status == text;
    return GestureDetector(
      onTap: () => setState(() => status = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? color : SetColors.primaryColor.withAlpha(30),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : SetColors.primaryColor.withAlpha(10),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 11,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(color: color),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 2,
                        height: 2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? textColor : SetColors.accentColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF7BA89B),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F9F7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _handleSubmit() {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    final updatedtodo = {
      'title': titleController.text,
      'description': descriptionController.text,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'startTime':
          startTime != null ? '${startTime!.hour}:${startTime!.minute}' : null,
      'endTime': endTime != null ? '${endTime!.hour}:${endTime!.minute}' : null,
      'status': status,
      'priority': priority,
      'label': label,
    };

    Navigator.pop(context, updatedtodo);
  }
}
