import 'package:busca_cep_clean/app/domain/errors/errors.dart';
import 'package:busca_cep_clean/app/data/datasources/search_cep_datasource.dart';
import 'package:busca_cep_clean/app/data/repositories/search_cep_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  
  late SearchCepRepositoryImpl repository;
  late SearchCepDatasource datasource;

  setUp(() {
    registerFallbackValue(searchCepByTextUseCaseParamsMock);
    datasource = SearchCepDatasourceMock();
    repository = SearchCepRepositoryImpl(datasource);
  });

  group("Quando o repository.searchCep() for chamado,", () {
    test("Deve retornar um cepModel", () async {
      // Arrange
      when(() => datasource.getSearchCep(any())).thenAnswer((_) async => cepModelMock);
      // Act
      final result = await repository.searchCep(searchCepByTextUseCaseParamsMock);
      // Assert
      expect(result, const Right(cepModelMock));
      verify(() => datasource.getSearchCep(any())).called(1);
    });

    test("Deve retornar uma DatasourceError se o datasource falhar", () async {
      // Arrange
      when(() => datasource.getSearchCep(any())).thenThrow(Exception());
      // Act
      final result = await repository.searchCep(searchCepByTextUseCaseParamsMock);
      // Assert
      expect(result.fold(id, id), isA<DatasourceError>());
      verify(() => datasource.getSearchCep(any())).called(1);
    });
  });
}