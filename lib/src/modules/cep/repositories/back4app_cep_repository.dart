import 'package:projetos_flutter_dio/core/back4app_custom_dio.dart';
import 'package:projetos_flutter_dio/src/modules/cep/interceptors/back4app_cep_dio_interceptor.dart';
import 'package:projetos_flutter_dio/src/modules/cep/models/back4app_cep_model.dart';

class Back4AppCepRepository {
  final _customDio = Back4AppCustomDio(
    dioInterceptor: Back4AppCepDioInterceptor(),
  );
  final String _url = '/CEP';

  Back4AppCepRepository();

  Future<Back4AppCEPsModel> listCEP() async {
    var result = await _customDio.dio.get(_url);
    return Back4AppCEPsModel.fromJson(result.data);
  }

  Future<void> createCEP(Back4AppCepModel cep) async {
    try {
      await _customDio.dio.post(_url, data: cep.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateCEP({required Back4AppCepModel cep}) async {
    try {
      await _customDio.dio.put('$_url/${cep.objectId}', data: cep.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCEP(String cepId) async {
    try {
      await _customDio.dio.delete('$_url/$cepId');
    } catch (e) {
      rethrow;
    }
  }
}
