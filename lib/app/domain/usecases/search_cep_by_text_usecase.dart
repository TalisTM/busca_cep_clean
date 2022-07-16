import 'package:busca_cep_clean/app/domain/entities/cep_entity.dart';
import 'package:busca_cep_clean/app/domain/errors/errors.dart';
import 'package:busca_cep_clean/app/domain/repositories/search_cep_repository.dart';
import 'package:dartz/dartz.dart';

abstract class SearchCepByTextUseCase {
  Future<Either<FailureSearch, CepEntity>> call(SearchCepByTextUseCaseParams params);
}

class SearchCepByTextUseCaseParams {
  final String cep;

  const SearchCepByTextUseCaseParams({required this.cep});
}

class SearchCepByTextUseCaseImpl implements SearchCepByTextUseCase {

  final SearchCepRepository repository;

  SearchCepByTextUseCaseImpl(this.repository);

  @override
  Future<Either<FailureSearch, CepEntity>> call(SearchCepByTextUseCaseParams params) async {

    if(params.cep.isEmpty || params.cep.length != 8 || params.cep.contains(RegExp('[A-Za-z]'))) {
      return Left(InvalidCepTextError());
    }

    return await repository.searchCep(params);
  }

}