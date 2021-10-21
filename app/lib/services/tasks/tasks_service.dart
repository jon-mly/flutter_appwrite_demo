import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_demo/app/auth/providers/auth_providers.dart';
import 'package:appwrite_demo/app/general_providers/config_providers.dart';
import 'package:appwrite_demo/models/classes/task.dart';
import 'package:appwrite_demo/services/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ITasksService {
  Stream<RealtimeMessage> getTasksStream();
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(Task task);
}

class TasksService implements ITasksService {
  final Reader _read;

  TasksService(this._read);

  //
  // Streams with Realtime
  //

  Stream<RealtimeMessage> getTasksStream() {
    final Realtime realtime = _read(appwriteRealtimeProvider);
    final String collectionId = _read(configurationProvider).appwriteDbTasksId;
    final RealtimeSubscription tasksSubscription =
        realtime.subscribe(["collections.$collectionId.documents"]);

    return tasksSubscription.stream;
  }

  //
  // CRUD with Tasks
  //

  @override
  Future<List<Task>> getTasks() async {
    final String collectionId = _read(configurationProvider).appwriteDbTasksId;

    final String? userId = _read(userIdProvider);
    // In real scenario, should throw an error to indicate a problem with the
    // general flow of the app.
    if (userId == null) return [];

    return await _read(appwriteDatabaseProvider).listDocuments(
        collectionId: collectionId,
        filters: ["userId=$userId"]).then((DocumentList list) {
      return list.documents
          .map((Document doc) => Task.fromAppWrite(doc.data))
          .toList();
    });
  }

  @override
  Future<void> addTask(Task task) async {
    final String collectionId = _read(configurationProvider).appwriteDbTasksId;

    final String? userId = _read(userIdProvider);
    // In real scenario, should throw an error to indicate a problem with the
    // general flow of the app.

    task.userId = userId;

    await _read(appwriteDatabaseProvider)
        .createDocument(collectionId: collectionId, data: task.toMap());
  }

  @override
  Future<void> updateTask(Task task) async {
    // In normal scenario, should throw to indicate a wrong usage of this method
    if (task.id == null) return;

    final String collectionId = _read(configurationProvider).appwriteDbTasksId;
    await _read(appwriteDatabaseProvider).updateDocument(
        collectionId: collectionId, documentId: task.id!, data: task.toMap());
  }

  @override
  Future<void> deleteTask(Task task) async {
    // In normal scenario, should throw to indicate a wrong usage of this method
    if (task.id == null) return;

    final String collectionId = _read(configurationProvider).appwriteDbTasksId;
    await _read(appwriteDatabaseProvider)
        .deleteDocument(collectionId: collectionId, documentId: task.id!);
  }
}
