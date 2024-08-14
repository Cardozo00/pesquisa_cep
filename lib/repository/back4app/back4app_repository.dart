import 'package:pesquisacep/model/back4app_model.dart';
import 'package:pesquisacep/repository/back4app/custon_back4app.dart';

class Back4appRepository {
  final _custonDio = CustonBack4app();

  Back4appRepository();

  Future<Back4AppModel> obterCep() async {
    var url = "/Viacep";
    var result = await _custonDio.dio.get(url);
    return Back4AppModel.fromJson(result.data);
  }

  Future<void> criar(Back4appModelCep back4AppModelCep) async {
    try {
      await _custonDio.dio
          .post("/Viacep", data: back4AppModelCep.toJsonEndPoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await _custonDio.dio.delete("/Viacep/$objectId");
    } catch (e) {
      throw e;
    }
  }
}
