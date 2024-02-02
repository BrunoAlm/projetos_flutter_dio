class Back4AppCEPsModel {
  final List<Back4AppCepModel> ceps;

  Back4AppCEPsModel({required this.ceps});

  factory Back4AppCEPsModel.fromJson(Map<String, dynamic> json) {
    var resultsJson = json['results'] as List<dynamic>?;

    if (resultsJson != null) {
      var results = resultsJson.map((v) => Back4AppCepModel.fromJson(v)).toList();
      return Back4AppCEPsModel(ceps: results);
    } else {
      return Back4AppCEPsModel(ceps: []);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = ceps.map((v) => v.toJson()).toList();
    return data;
  }
}

class Back4AppCepModel {
  final String objectId;
  final String cep;
  final String logradouro;
  final String bairro;
  final String ddd;
  final String cidade;
  final String complemento;
  final String estado;
  final String createdAt;
  final String updatedAt;

  Back4AppCepModel({
    required this.objectId,
    required this.cep,
    required this.logradouro,
    required this.bairro,
    required this.ddd,
    required this.cidade,
    required this.complemento,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Back4AppCepModel.fromJson(Map<String, dynamic> json) {
    return Back4AppCepModel(
      objectId: json['objectId'],
      cep: json['cep'],
      logradouro: json['logradouro'],
      bairro: json['bairro'],
      ddd: json['ddd'],
      cidade: json['cidade'],
      complemento: json['complemento'],
      estado: json['estado'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['bairro'] = bairro;
    data['ddd'] = ddd;
    data['cidade'] = cidade;
    data['complemento'] = complemento;
    data['estado'] = estado;
    return data;
  }
}
