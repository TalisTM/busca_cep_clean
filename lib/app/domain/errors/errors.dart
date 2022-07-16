abstract class FailureSearch implements Exception {}

class InvalidCepTextError implements FailureSearch {}

class DatasourceError implements FailureSearch {}