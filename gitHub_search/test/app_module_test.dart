import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitHub_search/app_module.dart';
import 'package:gitHub_search/modules/search/domain/entities/result_search.dart';
import 'package:gitHub_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:gitHub_search/modules/search/utils/github_response.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) =>  dio),
  ]);
  test('Deve recuperar useCase sem erro', () {
    
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImpl>());
  });


  test('Deve trazer uma lista de resultSearch ', () async{
    when(dio.get(any)).thenAnswer((_) async =>
        Response(data: jsonDecode(githubResponse), statusCode: 200));

    final usecase = Modular.get<SearchByText>();
    final result = await usecase("Mateus");
    expect(result | null, isA<List<ResultSearch>>());
  });
}
