import 'dart:convert';

import 'package:busca_cep_clean/app/app_module.dart';
import 'package:busca_cep_clean/app/presenter/search_cep_store.dart';

import 'package:busca_cep_clean/app/presenter/states/search_cep_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import '../mocks.dart';

void main() {
  Dio dioMock;

  setUp(() {
    registerFallbackValue(searchCepByTextUseCaseParamsMock);
    
    dioMock = DioMock();

    initModule(AppModule(), replaceBinds: [Bind<Dio>((i) => dioMock)]);

    when(() => dioMock.get(any())).thenAnswer((_) async => Response(data: jsonDecode(cepJsonMock), statusCode: 200, requestOptions: RequestOptions(path: "")));
  });

  test("Deve retornar um SuccessState", () async {
    var store = Modular.get<SearchCepStore>();
    var result = await store.makeSearchCep(cepMock);
    expect(result, isA<SuccessState>());
  });

  test("Deve trocar o estado para successState", () async {
    var store = Modular.get<SearchCepStore>();
    await store.stateReaction(cepMock);
    expect(store.state, isA<SuccessState>());
  });
}