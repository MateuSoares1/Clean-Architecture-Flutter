import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitHub_search/modules/search/domain/entities/result_search.dart';
import 'package:gitHub_search/modules/search/domain/errors/errors.dart';
import 'package:gitHub_search/modules/search/domain/repositories/search_repository.dart';
import 'package:gitHub_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:mockito/mockito.dart';

class  SearchRepositoryMock extends Mock implements SearchRepository {}
main() {

  final repository = SearchRepositoryMock();

  final usecases = SearchByTextImpl(repository);

    test('Deve retornar uma Lista de ResultSearch', () async {
      
      when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));

      final result = await usecases("Mateus");      
      expect(result | null, isA<List<ResultSearch>>());  
    });

    test('Deve retornar um Erro caso o texto seja invalido', () async {
      
      when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));

      var result = await usecases(null);      
     
      expect(result.fold(id, id), isA<InvalideTextError>());

      result = await usecases("");      
     
      expect(result.fold(id, id), isA<InvalideTextError>());  
    });   
}

