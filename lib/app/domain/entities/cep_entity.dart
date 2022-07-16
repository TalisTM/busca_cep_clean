import 'package:equatable/equatable.dart';

class CepEntity extends Equatable {

  final String cep;
  final String rua;
  final String bairro;
  final String cidade;
  final String uf;

  const CepEntity({required this.cep, required this.rua, required this.bairro, required this.cidade, required this.uf});

  @override
  List<Object?> get props => [cep, rua, bairro, cidade, uf];

}