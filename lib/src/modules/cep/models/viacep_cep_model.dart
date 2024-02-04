class ViaCepCepModel {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String ibge;
  final String gia;
  final String ddd;
  final String siafi;

  ViaCepCepModel({
    this.cep = '',
    this.logradouro = '',
    this.complemento = '',
    this.bairro = '',
    this.localidade = '',
    this.uf = '',
    this.ibge = '',
    this.gia = '',
    this.ddd = '',
    this.siafi = '',
  });

  factory ViaCepCepModel.fromJson(Map<String, dynamic> json) {
    return ViaCepCepModel(
      cep: _checkValue(json['cep']),
      logradouro: _checkValue(json['logradouro']),
      complemento: _checkValue(json['complemento']),
      bairro: _checkValue(json['bairro']),
      localidade: _checkValue(json['localidade']),
      uf: _checkValue(json['uf']),
      ibge: _checkValue(json['ibge']),
      gia: _checkValue(json['gia']),
      ddd: _checkValue(json['ddd']),
      siafi: _checkValue(json['siafi']),
    );
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
