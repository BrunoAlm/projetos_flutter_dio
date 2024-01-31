import 'dart:convert';
import 'package:first_proj_flutter_dio/src/cep/viacep_model.dart';
import 'package:http/http.dart' as http;

class ViaCepRepository {
  Future<ViaCepModel> listCEP(String cep) async {
    var response = await http.get(
      Uri.parse("https://viacep.com.br/ws/$cep/json/"),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return ViaCepModel.fromJson(json);
    }

    return ViaCepModel();
  }
}
