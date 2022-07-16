import 'package:busca_cep_clean/app/domain/entities/cep_entity.dart';
import 'package:busca_cep_clean/app/domain/repositories/search_cep_repository.dart';
import 'package:busca_cep_clean/app/domain/usecases/search_cep_by_text_usecase.dart';
import 'package:busca_cep_clean/app/data/datasources/search_cep_datasource.dart';
import 'package:busca_cep_clean/app/data/models/cep_model.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

const String cepMock = "29317005";

const SearchCepByTextUseCaseParams searchCepByTextUseCaseParamsMock = SearchCepByTextUseCaseParams(cep: "29317005");

class SearchCepRepositoryMock extends Mock implements SearchCepRepository {}

const CepEntity cepEntityMock = CepEntity(cep: "29317-005", rua: "Rua Anísio Figueiredo", bairro: "Parque das Laranjeiras", cidade: "Cachoeiro de Itapemirim", uf: "ES");

class SearchCepDatasourceMock extends Mock implements SearchCepDatasource {}

const CepModel cepModelMock = CepModel(cep: "29317-005", rua: "Rua Anísio Figueiredo", bairro: "Parque das Laranjeiras", cidade: "Cachoeiro de Itapemirim", uf: "ES");

const cepJsonMock = """{
  "cep": "29317-005",
  "logradouro": "Rua Anísio Figueiredo",
  "complemento": "",
  "bairro": "Parque das Laranjeiras",
  "localidade": "Cachoeiro de Itapemirim",
  "uf": "ES",
  "ibge": "3201209",
  "gia": "",
  "ddd": "28",
  "siafi": "5623"
}""";

class DioMock extends Mock implements Dio {}

const String urlMock = "https://viacep.com.br/ws/29317005/json/";