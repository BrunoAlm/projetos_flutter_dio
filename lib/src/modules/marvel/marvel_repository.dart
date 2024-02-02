import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:projetos_flutter_dio/src/modules/marvel/characters/marvel_characters_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MarvelRepository {
  Future<MarvelCharactersModel> getCharacters(int offset) async {
    Dio dio = Dio();

    String ts = DateTime.now().microsecondsSinceEpoch.toString();
    String publicKey = dotenv.get("MARVEL_PUBLIC_KEY");
    String privateKey = dotenv.get("MARVEL_API_KEY");
    String hash = _generateMd5(ts + privateKey + publicKey);
    String query = "offset=$offset&ts=$ts&apikey=$publicKey&hash=$hash";

    var url = dotenv.get('MARVEL_CHARACTERS_BASE_URL');
    var result = await dio.get("$url?$query");
    return MarvelCharactersModel.fromJson(result.data);
  }

  String _generateMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
