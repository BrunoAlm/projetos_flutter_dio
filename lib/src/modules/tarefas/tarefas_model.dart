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
  final String objectId;
  final String description;
  final bool finished;
  final String createdAt;
  final String updatedAt;

  TaskModel({
    required this.objectId,
    required this.description,
    required this.finished,
    required this.createdAt,
    required this.updatedAt,
  });

  TaskModel.newTask({
    this.objectId = '',
    this.createdAt = '',
    this.updatedAt = '',
    required this.description,
    required this.finished,
  });

  set finished(bool finished) => this.finished = finished;

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      objectId: json['objectId'],
      description: json['descricao'],
      finished: json['concluido'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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
