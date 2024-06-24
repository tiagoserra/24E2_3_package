import 'package:location/location.dart';

class Task {
  String? id;
  String name;
  DateTime dateTime;
  String image;

  Task({this.id, required this.name, required this.dateTime, required this.image});

  Task.fromJson(String this.id, Map<String, dynamic> json)
      : name = json['name'],
        dateTime = DateTime.parse(json['dateTime']),
        image = json['image'];

  Map<String, dynamic> toJson() =>
      {'name': name, 'dateTime': dateTime.toIso8601String(), 'image': image};
}