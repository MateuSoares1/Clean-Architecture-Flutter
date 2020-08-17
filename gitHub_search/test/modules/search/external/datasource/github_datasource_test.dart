import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitHub_search/modules/search/domain/errors/errors.dart';
import 'package:gitHub_search/modules/search/external/datasource/githubDatasource.dart';
import 'package:gitHub_search/modules/search/utils/github_response.dart';
import 'package:mockito/mockito.dart';


class DioMock extends Mock implements Dio {}
main() {
  final dio = DioMock();
  final datasource =  GithubDatasource(dio);
  test('Deve retornar uma lista de ResultSearchModel', () async {    

    when(dio.get(any)).thenAnswer(
      (_) async => Response(data: jsonDecode(githubResponse) , statusCode: 200));

    final future =  datasource.getSearch("Mateus");

    expect(future, completes);
  });

  test('Deve retornar um erro se o codigo não for 200', () async {
    

    when(dio.get(any)).thenAnswer((_) async => Response(data: null, statusCode: 401));

    final future =  datasource.getSearch("searchText");

    expect(future, throwsA(isA<DatasourceError>()));
  });
}