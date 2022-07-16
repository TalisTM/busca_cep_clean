import 'package:busca_cep_clean/app/presenter/search_cep_page.dart';
import 'package:busca_cep_clean/app/presenter/search_cep_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../app/domain/usecases/search_cep_by_text_usecase.dart';
import '../app/external/datasources/via_cep_datasource.dart';
import '../app/data/repositories/search_cep_repository_impl.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
    Bind<Dio>((i) => Dio()),
    Bind((i) => SearchCepByTextUseCaseImpl(i())),
    Bind((i) => SearchCepRepositoryImpl(i())),
    Bind((i) => ViaCepDatasource(i())),
    Bind((i) => SearchCepStore(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, __) => const SearchCepPage())
  ];
}