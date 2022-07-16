import 'package:busca_cep_clean/app/domain/errors/errors.dart';
import 'package:busca_cep_clean/app/domain/usecases/search_cep_by_text_usecase.dart';
import 'package:busca_cep_clean/app/data/datasources/search_cep_datasource.dart';
import 'package:busca_cep_clean/app/data/models/cep_model.dart';
import 'package:dio/dio.dart';

import 'endpoints/via_cep_endpoint.dart';

class ViaCepDatasource implements SearchCepDatasource {

  final Dio dio;
  ViaCepDatasource(this.dio);
  
  @override
  Future<CepModel> getSearchCep(SearchCepByTextUseCaseParams params) async {

    final response = await dio.get(ViaCepEndpoints.viaCep(params.cep));
    if(response.statusCode == 200) {
      final cepResponse = CepModel.fromJson(response.data);
      return cepResponse;
    } else {
      throw DatasourceError();
    }
  }

  
}