import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:management_task_package/models/task_model.dart';
import 'package:management_task_package/providers/firebase_provider.dart';
import 'package:management_task_package/services/task_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// run=> flutter pub run build_runner build
import 'mocks/task_service_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<FirebaseProvider>(as: #MockFirebaseProvider)
])
void main() {
  group('TaskService', () {
    late MockFirebaseProvider mockFirebaseProvider;

    setUp(() {
      mockFirebaseProvider = MockFirebaseProvider();
    });

    test('insert returns task with id', () async {
      final task = Task(name: "Test Task", dateTime: DateTime.now());
      final taskJson = jsonEncode(task.toJson());
      const mockId = '123';

      when(FirebaseProvider.httpPost(
        "https://flutter-tasks-27c22-default-rtdb.firebaseio.com/",
        "tasks",
        task.toJson().toString()
      )).thenAnswer((_) async => mockId);

      final result = await TaskService.insert(task);

        expect(result.id, mockId);
        verify(FirebaseProvider.httpPost(TaskService.url, TaskService.resource, taskJson)).called(1);
    });

    test('update returns updated task', () async {
      final task = Task(id: '123', name: "Test Task", dateTime: DateTime.now());
      final taskJson = jsonEncode(task.toJson());

      when(FirebaseProvider.httpPut(
        "https://flutter-tasks-27c22-default-rtdb.firebaseio.com/",
        "tasks",
        task.toJson().toString()  
      )).thenAnswer((_) async => '');

      final result = await TaskService.update(task);

      expect(result, task);
      verify(FirebaseProvider.httpPut(TaskService.url, '${TaskService.resource}/${task.id}', taskJson)).called(1);
    });

    test('delete returns true', () async {
      final task = Task(id: '123', name: "Test Task", dateTime: DateTime.now());

      // Mockando o método estático
      when(FirebaseProvider.httpDelete(
        "https://flutter-tasks-27c22-default-rtdb.firebaseio.com/",
        "tasks",
      )).thenAnswer((_) async => '');

      final result = await TaskService.delete(task);

      expect(result, true);
      verify(FirebaseProvider.httpDelete(TaskService.url, '${TaskService.resource}/${task.id}')).called(1);
    });

    test('getAll returns list of tasks', () async {
      final mockResponse = jsonEncode({
        '123': {'name': 'Test Task 1', 'dateTime': DateTime.now().toIso8601String()},
        '456': {'name': 'Test Task 2', 'dateTime': DateTime.now().toIso8601String()},
      });

      when(FirebaseProvider.httpGet(
        "https://flutter-tasks-27c22-default-rtdb.firebaseio.com/",
        "tasks",
      )).thenAnswer((_) async => mockResponse);

      final result = await TaskService.getAll();

      expect(result.length, 2);
      expect(result[0].id, '123');
      expect(result[0].name, 'Test Task 1');
      expect(result[1].id, '456');
      expect(result[1].name, 'Test Task 2');
      verify(FirebaseProvider.httpGet(TaskService.url, TaskService.resource)).called(1);
    });

    test('getById returns a task', () async {
      final mockResponse = jsonEncode({'name': 'Test Task', 'dateTime': DateTime.now().toIso8601String()});

      // Mockando o método estático
      when(FirebaseProvider.httpGet(
        "https://flutter-tasks-27c22-default-rtdb.firebaseio.com/",
        "tasks",
      )).thenAnswer((_) async => mockResponse);

      final result = await TaskService.getById('123');

      expect(result.id, '123');
      expect(result.name, 'Test Task');
      verify(FirebaseProvider.httpGet(TaskService.url, '${TaskService.resource}/123.json')).called(1);
    });
  });
}