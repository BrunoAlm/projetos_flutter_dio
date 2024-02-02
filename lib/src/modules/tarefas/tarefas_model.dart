// ignore_for_file: public_member_api_docs, sort_constructors_first
class TasksModel {
  final List<TaskModel> tarefas;

  TasksModel({
    required this.tarefas,
  });

  factory TasksModel.fromJson(Map<String, dynamic> json) {
    var resultsJson = json['results'] as List<dynamic>?;

    if (resultsJson != null) {
      var results = resultsJson.map((v) => TaskModel.fromJson(v)).toList();
      return TasksModel(tarefas: results);
    } else {
      return TasksModel(tarefas: []);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = tarefas.map((v) => v.toJson()).toList();
    return data;
  }
}

class TaskModel {
  String? objectId;
  String description;
  bool finished;
  String? createdAt;
  String? updatedAt;

  TaskModel({
    required this.objectId,
    required this.description,
    required this.finished,
    required this.createdAt,
    required this.updatedAt,
  });

  TaskModel.newTask({
    required this.description,
    required this.finished,
  });

  factory TaskModel.fromJson(Map<String, dynamic> map) {
    return TaskModel(
      objectId: map['objectId'],
      description: map['descricao'],
      finished: map['concluido'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = description;
    data['concluido'] = finished;
    return data;
  }

  TaskModel copyWith({
    String? objectId,
    String? description,
    bool? finished,
    String? createdAt,
    String? updatedAt,
  }) {
    return TaskModel(
      objectId: objectId ?? this.objectId,
      description: description ?? this.description,
      finished: finished ?? this.finished,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
