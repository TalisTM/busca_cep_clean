import 'package:busca_cep_clean/app/domain/entities/cep_entity.dart';
import 'package:busca_cep_clean/app/domain/errors/errors.dart';
import 'package:busca_cep_clean/app/domain/repositories/search_cep_repository.dart';
import 'package:busca_cep_clean/app/domain/usecases/search_cep_by_text_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  
  late SearchCepRepository repository;
  late SearchCepByTextUseCase usecase;

  setUp(() {
    registerFallbackValue(searchCepByTextUseCaseParamsMock);
    repository = SearchCepRepositoryMock();
    usecase = SearchCepByTextUseCaseImpl(repository);
  });

  group("Quando o SearchCepByTextUseCase for chamado,", () {
    test("Deve retornar um CepEntity", () async {
      when(() => repository.searchCep(any())).thenAnswer((_) async => const Right(cepEntityMock));

      final result = await usecase(searchCepByTextUseCaseParamsMock);
      verify(() => repository.searchCep(any())).called(1);
      expect(result, const Right(cepEntityMock));
    });

    test("Deve retornar um InvalidCepTextError quando o texto for inválido", () async {
      when(() => repository.searchCep(any())).thenAnswer((_) async => const Right(cepEntityMock));

      const List<String> ceps = ["", "2931700", "293170055", "abc17005", "29317abc", "abcdefgh", "DEF17005", "29317DEF", "IJKLMNOP"];
      
      Either<FailureSearch, CepEntity> result;
      for(String cep in ceps) {
        result = await usecase(SearchCepByTextUseCaseParams(cep: cep));
        expect(result.fold(id, id), isA<InvalidCepTextError>());
      }

      verifyNever(() => repository.searchCep(any()));
    });
  });
}