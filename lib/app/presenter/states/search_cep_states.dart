import 'package:busca_cep_clean/app/domain/entities/cep_entity.dart';
import 'package:busca_cep_clean/app/domain/errors/errors.dart';

abstract class SearchCepState {}

class StartState implements SearchCepState {
  const StartState();
}

class LoadingState implements SearchCepState {
  const LoadingState();
}

class ErrorState implements SearchCepState {
  final FailureSearch error;
  const ErrorState(this.error);
}

class SuccessState implements SearchCepState {
  final CepEntity cep;
  const SuccessState(this.cep);
}