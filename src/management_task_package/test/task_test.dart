import 'package:management_task_package/models/task_model.dart';
import 'package:test/test.dart';

void main() {
  group('Task', () {
    test('Task can be created from JSON', () {
      final json = {
        'name': 'Test Task',
        'dateTime': DateTime.now().toIso8601String()
      };

      final task = Task.fromJson('123', json);

      expect(task.id, '123');
      expect(task.name, 'Test Task');
      expect(task.dateTime, DateTime.parse(json['dateTime']!));
    });

    test('Task can be converted to JSON', () {
      final task = Task(
        id: '123',
        name: 'Test Task',
        dateTime: DateTime.now(),
        image: 'image',
      );

      final json = task.toJson();

      expect(json['name'], 'Test Task');
      expect(json['dateTime'], task.dateTime.toIso8601String());
    });

    test('Task properties are set correctly', () {
      final dateTime = DateTime.now();
      final task = Task(
        id: '123',
        name: 'Test Task',
        dateTime: dateTime,
        image: 'image'
      );

      expect(task.id, '123');
      expect(task.name, 'Test Task');
      expect(task.dateTime, dateTime);
      expect(task.image, 'image');
    });
  });
}