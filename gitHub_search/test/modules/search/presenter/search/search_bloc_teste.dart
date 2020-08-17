import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitHub_search/modules/search/domain/entities/result_search.dart';
import 'package:gitHub_search/modules/search/domain/errors/errors.dart';
import 'package:gitHub_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:gitHub_search/modules/search/presenter/search/search_bloc.dart';
import 'package:gitHub_search/modules/search/presenter/state/search_state.dart';
import 'package:mockito/mockito.dart';

class SearchByTextMock extends Mock implements SearchByText {}

main() {
  final usecases = SearchByTextMock();
  final bloc = SearchBloc(usecases);

  test('Deve retornar os estados na ordem correta', () {
    when(usecases.call(any)).thenAnswer((_) async => Right(<ResultSearch>[]));

    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchSucess>(),
        ]));

    bloc.add("Mateus");
  });

  test('Deve retornar error', () {
    when(usecases.call(any)).thenAnswer((_) async => Left(InvalideTextError()));

    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchError>(),
        ]));

    bloc.add("Mateus");
  });
}
