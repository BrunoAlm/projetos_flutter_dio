import 'package:projetos_flutter_dio/core/back4app_custom_dio.dart';
import 'package:projetos_flutter_dio/main.dart';
import 'package:projetos_flutter_dio/src/modules/tarefas/back4app_tarefas_dio_interceptor.dart';
import 'package:projetos_flutter_dio/src/modules/tarefas/tarefas_model.dart';

class TasksRepository {
  final _customDio = Back4AppCustomDio(di<Back4AppTarefasDioInterceptor>());
  TasksRepository();

  Future<TasksModel> getTasks(bool finished) async {
    String url = '/Tarefas';

    if (finished) {
      url = '$url?where={"concluido":false}';
    }
    var result = await _customDio.dio.get(url);
    return TasksModel.fromJson(result.data);
  }

  Future<void> createTask(TaskModel task) async {
    String url = '/Tarefas';

    try {
      await _customDio.dio.post(url, data: task.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTask({required TaskModel task}) async {
    String url = '/Tarefas';

    try {
      await _customDio.dio.put('$url/${task.objectId}', data: task.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId) async {
    String url = '/Tarefas';

    try {
      await _customDio.dio.delete('$url/$taskId');
    } catch (e) {
      rethrow;
    }
  }
}
