import 'package:busca_cep_clean/app/domain/usecases/search_cep_by_text_usecase.dart';
import 'package:busca_cep_clean/app/presenter/states/search_cep_states.dart';
import 'package:mobx/mobx.dart';
import 'package:async/async.dart';
part 'search_cep_store.g.dart';

class SearchCepStore = _SearchCepStoreBase with _$SearchCepStore;

abstract class _SearchCepStoreBase with Store {
  final SearchCepByTextUseCase searchCepByTextUseCase;
  CancelableOperation? cancelableOperation;

  _SearchCepStoreBase(this.searchCepByTextUseCase) {
    reaction(
      (_) => cep,
      (String cep) async {
        stateReaction(cep, cancelableOperation);
      },
      delay: 500
    );
  }

  Future stateReaction(String cep, [CancelableOperation? cancelableOperation]) async {
    await cancelableOperation?.cancel();

    cancelableOperation = CancelableOperation<SearchCepState>.fromFuture(makeSearchCep(cep));

    if(cep.isEmpty) {
      setState(const StartState());
      return;
    }

    setState(const LoadingState());

    setState(await cancelableOperation.valueOrCancellation(const LoadingState()));
  }

  Future<SearchCepState> makeSearchCep(String cep) async {
    var result = await searchCepByTextUseCase(SearchCepByTextUseCaseParams(cep: cep));
    return result.fold((error) => ErrorState(error), (success) => SuccessState(success));
  }

  @observable
  String cep = "";

  @observable
  SearchCepState state = const StartState();

  @action
  setSearchCep(String value) => cep = value.replaceAll(".", "").replaceAll("-", "");

  @action
  setState(SearchCepState value) => state = value;

}