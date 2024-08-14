import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pesquisacep/model/via_cep_model.dart';

class ViaCepRepository {
  Dio dio = Dio();
  Future<ViaCepModel> consultarCep(String cep) async {
    var response =
        await dio.getUri(Uri.parse("https://viacep.com.br/ws/$cep/json/"));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.toString());
      return ViaCepModel.fromJson(json);
    }
    return ViaCepModel();
  }
}
