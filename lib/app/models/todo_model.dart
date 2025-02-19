import 'package:flutter/material.dart';

class Todo {
  final String title;
  final String description;
  final DateTime startDate;
  final TimeOfDay startTime;
  final DateTime endDate;
  final TimeOfDay endTime;
  final String priority;
  final String label;
  final String status;
  bool deleted;

  Todo({
    required this.title,
    required this.description,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    this.priority = "High",
    this.label = "Study",
    this.status = "Open",
    this.deleted = false,
  });

  String _timeOfDayToString(TimeOfDay timeOfDay) {
    final String hour = timeOfDay.hour.toString().padLeft(2, '0');
    final String minute = timeOfDay.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  // Convert task to map for storage
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'startTime': _timeOfDayToString(startTime),
      'endDate': endDate.toIso8601String(),
      'endTime': _timeOfDayToString(endTime),
      'status': status,
      'priority': priority,
      'label': label,
      'deleted': deleted,
    };
  }

  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'],
      description: map['description'] ?? "",
      startDate: DateTime.parse(map['startDate']),
      startTime: _stringToTimeOfDay(map['startTime']),
      endDate: DateTime.parse(map['endDate']),
      endTime: _stringToTimeOfDay(map['endTime']),
      status: map['status'] ?? "Open",
      priority: map['priority'] ?? "High",
      label: map['label'] ?? "Study",
      deleted: map['deleted'] ?? false,
    );
  }

  static TimeOfDay _stringToTimeOfDay(String? timeString) {
    if (timeString == null || !timeString.contains(':')) {
      return const TimeOfDay(hour: 0, minute: 0);
    }
    List<String> parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}
