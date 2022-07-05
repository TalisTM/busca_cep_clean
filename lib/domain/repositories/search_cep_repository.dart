import 'package:busca_cep_clean/domain/entities/cep_entity.dart';
import 'package:busca_cep_clean/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

abstract class SearchCepRepository {
  Future<Either<FailureSearch, CepEntity>> searchCep(String cep);
}