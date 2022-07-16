import 'package:busca_cep_clean/app/domain/usecases/search_cep_by_text_usecase.dart';
import 'package:busca_cep_clean/app/data/models/cep_model.dart';

abstract class SearchCepDatasource {
  Future<CepModel> getSearchCep(SearchCepByTextUseCaseParams params);
}