import 'dart:convert';

import 'package:busca_cep_clean/app/app_module.dart';
import 'package:busca_cep_clean/app/domain/usecases/search_cep_by_text_usecase.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import 'mocks.dart';

void main() {
  
  late Dio dioMock;
  
  setUpAll(() {
    registerFallbackValue(searchCepByTextUseCaseParamsMock);
    dioMock = DioMock();
    initModule(AppModule(), replaceBinds: [Bind<Dio>((i) => dioMock)]);
  });

  test("Deve recuperar o usecase sem erro", () {
    final usecase = Modular.get<SearchCepByTextUseCase>();
    expect(usecase, isA<SearchCepByTextUseCaseImpl>());
  });

  test("Deve trazer um CepEntity", () async {
    // Arrange
    when(
      () => dioMock.get(any())).thenAnswer((_) async => Response(
          data: jsonDecode(cepJsonMock),
          statusCode: 200,
          requestOptions: RequestOptions(path: ""),
        ),
    );
    final usecase = Modular.get<SearchCepByTextUseCase>();
    // Cct
    final result = await usecase(searchCepByTextUseCaseParamsMock);
    // assert
    expect(result, const dartz.Right(cepModelMock));
  });
}