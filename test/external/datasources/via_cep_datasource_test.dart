import 'dart:convert';

import 'package:busca_cep_clean/app/domain/errors/errors.dart';
import 'package:busca_cep_clean/app/external/datasources/via_cep_datasource.dart';
import 'package:busca_cep_clean/app/data/datasources/search_cep_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  
  late Dio dio;
  late SearchCepDatasource datasource;

  setUp(() {
    registerFallbackValue(searchCepByTextUseCaseParamsMock);
    dio = DioMock();
    datasource = ViaCepDatasource(dio);
  });

  successMock() {
    when(() => dio.get(any())).thenAnswer((_) async => Response(data: jsonDecode(cepJsonMock), statusCode: 200, requestOptions: RequestOptions(path: "")));
  }

  group("Quando o datasource for chamado,", () {
    test("Deve retornar a URL correta", () async {
      // Arrange
      successMock();
      // Act
      await datasource.getSearchCep(searchCepByTextUseCaseParamsMock);
      // Assert
      verify(() => dio.get(urlMock)).called(1);
    });
    
    test("Deve retornar um CepModel", () async {
      // Arrange
      successMock();
      // Act
      final result = await datasource.getSearchCep(searchCepByTextUseCaseParamsMock);
      // Assert
      expect(result, cepModelMock);
    });

    test("Deve retornar um DatasourceError se o code não for 200", () {
      // Arrange
      when(() => dio.get(any())).thenAnswer((_) async => Response(data: 'Error', statusCode: 401, requestOptions: RequestOptions(path: "")));
      // Act
      final result = datasource.getSearchCep(searchCepByTextUseCaseParamsMock);
      // Assert
      expect(() => result, throwsA(isA<DatasourceError>()));
    });
  });
}