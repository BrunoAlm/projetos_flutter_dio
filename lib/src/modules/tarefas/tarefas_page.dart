import 'package:projetos_flutter_dio/main.dart';
import 'package:projetos_flutter_dio/src/modules/tarefas/tarefas_model.dart';
import 'package:projetos_flutter_dio/src/modules/tarefas/tarefas_repository.dart';
import 'package:flutter/material.dart';

class TarefasPage extends StatefulWidget {
  final String title;

  const TarefasPage({super.key, required this.title});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  final tasksRepository = di<TasksRepository>();
  final _descriptionEC = TextEditingController();
  late TasksModel _tasks;
  var _finished = false;
  var _loading = false;

  @override
  void initState() {
    _tasks = TasksModel(tarefas: []);
    loadTasks();
    super.initState();
  }

  loadTasks() async {
    if (mounted) {
      setState(() {
        _loading = true;
      });

      _tasks = await tasksRepository.getTasks(_finished);
      setState(() {
        _loading = false;
      });
    }
  }

  void createTask(String description) async {
    await tasksRepository.createTask(
      TaskModel.newTask(
        description: description,
        finished: false,
      ),
    );
    loadTasks();
  }

  void updateTask(TaskModel task) async {
    await tasksRepository.updateTask(
      task: task,
    );
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _descriptionEC.text = "";
          showDialog(
            context: context,
            builder: (BuildContext bc) {
              return AlertDialog(
                title: const Text("Adicionar tarefa"),
                content: TextField(
                  controller: _descriptionEC,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancelar")),
                  TextButton(
                    onPressed: () {
                      createTask(_descriptionEC.text);
                      Navigator.pop(context);
                    },
                    child: const Text("Salvar"),
                  )
                ],
              );
            },
          );
        },
      ),
      body: _tasks.tarefas.isEmpty
          ? const Scaffold(
              body: Center(
                  child: Text(
              'Sem tarefas na lista! 😅',
              style: TextStyle(fontSize: 22),
            )))
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Apenas não concluídos",
                            style: TextStyle(fontSize: 18),
                          ),
                          Switch(
                            value: _finished,
                            onChanged: (bool value) {
                              _finished = value;
                              loadTasks();
                            },
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    _loading
                        ? const CircularProgressIndicator()
                        : Expanded(
                            child: ListView.builder(
                              itemCount: _tasks.tarefas.length,
                              itemBuilder: (BuildContext bc, int index) {
                                var task = _tasks.tarefas[index];
                                return Dismissible(
                                  onDismissed: (DismissDirection
                                      dismissDirection) async {
                                    await tasksRepository
                                        .deleteTask(task.objectId);
                                    loadTasks();
                                  },
                                  key: Key(task.description),
                                  child: ListTile(
                                    title: Text(task.description),
                                    trailing: Switch(
                                      value: task.finished,
                                      onChanged: (bool value) {
                                        task.finished = value;
                                        updateTask(task);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
