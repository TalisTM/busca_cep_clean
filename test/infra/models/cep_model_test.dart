import 'dart:convert';

import 'package:busca_cep_clean/app/domain/entities/cep_entity.dart';
import 'package:busca_cep_clean/app/data/models/cep_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';

void main() {
  group("Verificar se o CepModel", () {
    test("é uma subclasse do CepEntity", () {
      expect(cepModelMock, isA<CepEntity>());
    });

    test("é um modelo válido", () {
      // Arrange
      final Map<String, dynamic> jsonMap = json.decode(cepJsonMock);
      // Act
      final result = CepModel.fromJson(jsonMap);
      // Assert
      expect(result, cepModelMock);
    });

    test("retorna os dados corretos em Json", () {
      // Arrange
      final expectedMap = {
        "cep": "29317-005",
        "logradouro": "Rua Anísio Figueiredo",
        "bairro": "Parque das Laranjeiras",
        "localidade": "Cachoeiro de Itapemirim",
        "uf": "ES",
      };
      // Act
      final result = cepModelMock.toJson();
      // Assert
      expect(result, expectedMap);
    });
  });
}