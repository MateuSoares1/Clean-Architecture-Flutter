abstract class  FailureSearch implements Exception{}

class InvalideTextError implements FailureSearch {}


class DatasourceError implements FailureSearch {
  final String mensage;

  DatasourceError({this.mensage});
}