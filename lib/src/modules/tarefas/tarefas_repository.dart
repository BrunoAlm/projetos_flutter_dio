import 'package:first_proj_flutter_dio/src/modules/tarefas/back4app_custom_dio.dart';
import 'package:first_proj_flutter_dio/src/modules/tarefas/tarefas_model.dart';

class TasksRepository {
  final _customDio = Back4AppCustomDio();

  TasksRepository();

  Future<TasksModel> getTasks(bool finished) async {
    String url = '/Tarefas';
    if (finished) {
      url += '?where={"concluido":false}';
    }
    var result = await _customDio.dio.get(url);
    return TasksModel.fromJson(result.data);
  }

  Future<void> createTask(TaskModel task) async {
    try {
      await _customDio.dio.post('/Tarefas', data: task.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTask({required TaskModel task}) async {
    try {
      await _customDio.dio
          .put('/Tarefas/${task.objectId}', data: task.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _customDio.dio.delete('/Tarefas/$taskId');
    } catch (e) {
      rethrow;
    }
  }
}
