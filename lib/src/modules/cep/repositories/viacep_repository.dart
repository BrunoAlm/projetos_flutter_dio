import 'dart:convert';
import 'package:projetos_flutter_dio/src/modules/cep/models/viacep_cep_model.dart';
import 'package:http/http.dart' as http;

class ViaCepRepository {
  Future<ViaCepCepModel> listCEP(String cep) async {
    var response = await http.get(
      Uri.parse("https://viacep.com.br/ws/$cep/json/"),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return ViaCepCepModel.fromJson(json);
    }

    return ViaCepCepModel();
  }
}
