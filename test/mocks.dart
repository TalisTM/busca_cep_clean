import 'package:busca_cep_clean/domain/entities/cep_entity.dart';
import 'package:busca_cep_clean/domain/repositories/search_cep_repository.dart';
import 'package:mocktail/mocktail.dart';

class SearchCepRepositoryMock extends Mock implements SearchCepRepository {}

const cepEntityMock = CepEntity(cep: "29317005", rua: "rua", bairro: "bairro", cidade: "cidade", uf: "uf");