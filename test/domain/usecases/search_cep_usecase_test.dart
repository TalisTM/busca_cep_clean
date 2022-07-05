import 'package:busca_cep_clean/domain/repositories/search_cep_repository.dart';
import 'package:busca_cep_clean/domain/usecases/search_cep_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  
  late SearchCepRepository repository;
  late SearchCep usecase;

  setUp(() {
    repository = SearchCepRepositoryMock();
    usecase = SearchCepImpl(repository);
  });

  group("Quando o repository.searchCep() for chamado,", () {
    test("Deve retornar um CepEntity", () async {
      when(() => repository.searchCep(any())).thenAnswer((_) async => const Right(cepEntityMock));

      final result = await usecase("29317005");
      verify(() => repository.searchCep(any())).called(1);
      expect(result, isA<Right>());
    });

    test("Deve retornar um failure", () async {
      when(() => repository.searchCep(any())).thenAnswer((_) async => const Right(cepEntityMock));

      final result = await usecase("29317005");
      verify(() => repository.searchCep(any())).called(1);
      expect(result, isA<Right>());
    });
  });

  



}