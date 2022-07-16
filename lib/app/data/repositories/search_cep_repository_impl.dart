import 'package:busca_cep_clean/app/domain/usecases/search_cep_by_text_usecase.dart';
import 'package:dartz/dartz.dart';

import 'package:busca_cep_clean/app/domain/entities/cep_entity.dart';
import 'package:busca_cep_clean/app/domain/errors/errors.dart';
import 'package:busca_cep_clean/app/domain/repositories/search_cep_repository.dart';
import 'package:busca_cep_clean/app/data/datasources/search_cep_datasource.dart';

class SearchCepRepositoryImpl implements SearchCepRepository {

  final SearchCepDatasource datasource;

  SearchCepRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, CepEntity>> searchCep(SearchCepByTextUseCaseParams params) async {
    try {
      final result = await datasource.getSearchCep(params);
      return Right(result);
    } catch (e) {
      return Left(DatasourceError());
    }
  }

}
