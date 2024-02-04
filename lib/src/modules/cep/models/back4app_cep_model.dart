import 'package:projetos_flutter_dio/src/modules/cep/models/viacep_cep_model.dart';

class Back4AppCEPsModel {
  final List<Back4AppCepModel> ceps;

  Back4AppCEPsModel({required this.ceps});

  factory Back4AppCEPsModel.fromJson(Map<String, dynamic> json) {
    var resultsJson = json['results'] as List<dynamic>?;

    if (resultsJson != null) {
      var results =
          resultsJson.map((v) => Back4AppCepModel.fromJson(v)).toList();
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
      cep: json['cep'].toString(),
      logradouro: _checkValue(json['logradouro']),
      bairro: _checkValue(json['bairro']),
      ddd: _checkValue(json['ddd']),
      cidade: _checkValue(json['cidade']),
      complemento: _checkValue(json['complemento']),
      estado: _checkValue(json['estado']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  factory Back4AppCepModel.fromViaCepModel(ViaCepCepModel cepModel) {
    return Back4AppCepModel(
      objectId: '',
      cep: cepModel.cep,
      logradouro: cepModel.logradouro,
      bairro: cepModel.bairro,
      ddd: cepModel.ddd,
      cidade: cepModel.localidade,
      complemento: cepModel.complemento,
      estado: cepModel.uf,
      createdAt: '',
      updatedAt: '',
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

  static String _checkValue(dynamic value) {
    if (value == null) {
      return 'Não encontrado';
    } else if (value is String && value.isEmpty) {
      return 'Não cadastrado';
    }
    return value.toString();
  }
}
