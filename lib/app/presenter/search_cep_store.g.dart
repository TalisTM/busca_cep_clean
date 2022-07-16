// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_cep_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchCepStore on _SearchCepStoreBase, Store {
  late final _$cepAtom =
      Atom(name: '_SearchCepStoreBase.cep', context: context);

  @override
  String get cep {
    _$cepAtom.reportRead();
    return super.cep;
  }

  @override
  set cep(String value) {
    _$cepAtom.reportWrite(value, super.cep, () {
      super.cep = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_SearchCepStoreBase.state', context: context);

  @override
  SearchCepState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(SearchCepState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_SearchCepStoreBaseActionController =
      ActionController(name: '_SearchCepStoreBase', context: context);

  @override
  dynamic setSearchCep(String value) {
    final _$actionInfo = _$_SearchCepStoreBaseActionController.startAction(
        name: '_SearchCepStoreBase.setSearchCep');
    try {
      return super.setSearchCep(value);
    } finally {
      _$_SearchCepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setState(SearchCepState value) {
    final _$actionInfo = _$_SearchCepStoreBaseActionController.startAction(
        name: '_SearchCepStoreBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$_SearchCepStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cep: ${cep},
state: ${state}
    ''';
  }
}
