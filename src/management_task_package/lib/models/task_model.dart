import 'package:location/location.dart';

class Task {
  String? id;
  String name;
  DateTime dateTime;

  Task({
    this.id,
    required this.name,
    required this.dateTime
  });

  Task.fromJson(String this.id, Map<String, dynamic> json)
      : name = json['name'],
        dateTime = DateTime.parse(json['dateTime']);

  Map<String, dynamic> toJson() =>
      {'name': name, 'dateTime': dateTime.toIso8601String()};
}