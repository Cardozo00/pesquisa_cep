class Back4AppModel {
  List<Back4appModelCep> results = [];

  Back4AppModel(this.results);

  Back4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Back4appModelCep>[];
      json['results'].forEach((v) {
        results.add(Back4appModelCep.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}

class Back4appModelCep {
  String objectId = "";
  String cep = "";
  String rua = "";
  String cidade = "";
  String uf = "";
  String bairro = "";
  String createdAt = "";
  String updatedAt = "";

  Back4appModelCep(this.objectId, this.cep, this.rua, this.cidade, this.uf,
      this.bairro, this.createdAt, this.updatedAt);

  Back4appModelCep.criar(this.rua, this.bairro, this.cidade, this.uf, this.cep);

  Back4appModelCep.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    rua = json['rua'];
    cidade = json['cidade'];
    uf = json['uf'];
    bairro = json['bairro'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['rua'] = rua;
    data['cidade'] = cidade;
    data['uf'] = uf;
    data['bairro'] = bairro;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndPoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['rua'] = rua;
    data['cidade'] = cidade;
    data['uf'] = uf;
    data['bairro'] = bairro;
    return data;
  }
}
