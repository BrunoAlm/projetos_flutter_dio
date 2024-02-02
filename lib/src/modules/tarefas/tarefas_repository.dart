import 'package:dio/dio.dart';
import 'package:first_proj_flutter_dio/src/modules/tarefas/tarefas_model.dart';

class TasksRepository {
  late final Dio _dio;

  TasksRepository() {
    _dio = Dio();
    _dio.options.headers["X-Parse-Application-Id"] =
        "jlelK4wbVI0JPJebZWRWftVPjFUhFqbHD7Nac0FH";
    _dio.options.headers["X-Parse-REST-API-Key"] =
        "Z6cK9G688Hv6HadBvgecVNWahP5K5wMvJi1rJMDC";
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = 'https://parseapi.back4app.com/classes';
  }

  Future<TasksModel> getTasks(bool finished) async {
    String url = '/Tarefas';
    if (finished) {
      url += '?where={"concluido":false}';
    }
    var result = await _dio.get(url);
    return TasksModel.fromJson(result.data);
  }

  Future<void> createTask(TaskModel task) async {
    try {
      await _dio.post('/Tarefas', data: task.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTask(
      {required TaskModel task}) async {
    try {
      await _dio.put('/Tarefas/${task.objectId}', data: task.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _dio.delete('/Tarefas/$taskId');
    } catch (e) {
      rethrow;
    }
  }
}
