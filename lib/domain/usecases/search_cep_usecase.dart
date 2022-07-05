import 'package:busca_cep_clean/domain/entities/cep_entity.dart';
import 'package:busca_cep_clean/domain/errors/errors.dart';
import 'package:busca_cep_clean/domain/repositories/search_cep_repository.dart';
import 'package:dartz/dartz.dart';

abstract class SearchCep {
  Future<Either<FailureSearch, CepEntity>> call(String cep);
}

class SearchCepImpl implements SearchCep {

  final SearchCepRepository repository;

  SearchCepImpl(this.repository);

  @override
  Future<Either<FailureSearch, CepEntity>> call(String cep) async {
    return repository.searchCep(cep);
  }

}