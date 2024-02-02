import 'package:first_proj_flutter_dio/src/modules/tarefas/tarefas_model.dart';
import 'package:first_proj_flutter_dio/src/modules/tarefas/tarefas_repository.dart';
import 'package:flutter/material.dart';

class TarefasPage extends StatefulWidget {
  final String title;

  const TarefasPage({super.key, required this.title});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  late TasksRepository tasksRepository;
  late TasksModel tasks;
  final descriptionEC = TextEditingController();
  var finished = false;
  var loading = false;

  @override
  void initState() {
    tasksRepository = TasksRepository();
    tasks = TasksModel(tarefas: []);
    loadTasks();
    super.initState();
  }

  loadTasks() async {
    if (mounted) {
      setState(() {
        loading = true;
      });

      tasks = await tasksRepository.getTasks(finished);
      setState(() {
        loading = false;
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
          descriptionEC.text = "";
          showDialog(
            context: context,
            builder: (BuildContext bc) {
              return AlertDialog(
                title: const Text("Adicionar tarefa"),
                content: TextField(
                  controller: descriptionEC,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancelar")),
                  TextButton(
                    onPressed: () {
                      createTask(descriptionEC.text);
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
      body: tasks.tarefas.isEmpty
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
                            value: finished,
                            onChanged: (bool value) {
                              finished = value;
                              loadTasks();
                            },
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    loading
                        ? const CircularProgressIndicator()
                        : Expanded(
                            child: ListView.builder(
                              itemCount: tasks.tarefas.length,
                              itemBuilder: (BuildContext bc, int index) {
                                var task = tasks.tarefas[index];
                                return Dismissible(
                                  onDismissed: (DismissDirection
                                      dismissDirection) async {
                                    await tasksRepository
                                        .deleteTask(task.objectId!);
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
