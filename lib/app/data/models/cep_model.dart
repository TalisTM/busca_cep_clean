import 'package:busca_cep_clean/app/domain/entities/cep_entity.dart';

class CepModel extends CepEntity {
  const CepModel({
    required String cep,
    required String rua,
    required String bairro,
    required String cidade,
    required String uf
  }) : super(cep: cep, rua: rua, bairro: bairro, cidade: cidade, uf: uf);

  factory CepModel.fromJson(Map<String, dynamic> json) =>
  CepModel(
    cep: json['cep'],
    rua: json['logradouro'],
    bairro: json['bairro'],
    cidade: json['localidade'],
    uf: json['uf']
  );

  Map<String, dynamic> toJson() => {
    'cep': cep,
    'logradouro': rua,
    'bairro': bairro,
    'localidade': cidade,
    'uf': uf
  };
}
