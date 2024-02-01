import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:first_proj_flutter_dio/src/modules/marvel/characters/marvel_characters_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MarvelRepository {
  Future<MarvelCharactersModel> getCharacters(int offset) async {
    Dio dio = Dio();

    String ts = DateTime.now().microsecondsSinceEpoch.toString();
    String publicKey = dotenv.get("MARVELPUBLICKEY");
    String privateKey = dotenv.get("MARVELAPIKEY");
    String hash = _generateMd5(ts + privateKey + publicKey);
    String query = "offset=$offset&ts=$ts&apikey=$publicKey&hash=$hash";

    var result =
        await dio.get("http://gateway.marvel.com/v1/public/characters?$query");
    return MarvelCharactersModel.fromJson(result.data);
  }

  String _generateMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
