import 'package:flutter/material.dart';

class Timetable {
  final String? id;
  final String name;
  final int rows;
  final int columns;
  final String creatorId;
  final List<(TimeOfDay, TimeOfDay)> timeRanges;
  final List<List<String>> timetable;

  Timetable({
    this.id,
    required this.name,
    required this.rows,
    required this.columns,
    required this.creatorId,
    required this.timeRanges,
    required this.timetable,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      id: json['_id'],
      name: json['name'],
      rows: json['rows'],
      columns: json['columns'],
      creatorId: json['creatorId'],
      timeRanges: List<(TimeOfDay, TimeOfDay)>.from(
        json['timeRanges'].map(
          (x) => (
            TimeOfDay(hour: x['start']['hour'], minute: x['start']['minute']),
            TimeOfDay(hour: x['end']['hour'], minute: x['end']['minute'])
          ),
        ),
      ),
      timetable: List<List<String>>.from(json['timetable'].map((x) => List<String>.from(x.map((x) => x)))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rows': rows,
      'columns': columns,
      'creatorId': creatorId,
      'timeRanges': List<dynamic>.from(
        timeRanges.map(
          (x) => {
            'start': {
              'hour': '${x.$1.hour}',
              'minute': '${x.$1.minute}',
            },
            'end': {
              'hour': '${x.$2.hour}',
              'minute': '${x.$2.minute}',
            }
          },
        ),
      ),
      'timetable': List<dynamic>.from(timetable.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
  }
}
