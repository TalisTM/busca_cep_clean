import 'package:busca_cep_clean/app/domain/entities/cep_entity.dart';
import 'package:busca_cep_clean/app/domain/errors/errors.dart';
import 'package:busca_cep_clean/app/domain/usecases/search_cep_by_text_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class SearchCepRepository {
  Future<Either<FailureSearch, CepEntity>> searchCep(SearchCepByTextUseCaseParams params);
}