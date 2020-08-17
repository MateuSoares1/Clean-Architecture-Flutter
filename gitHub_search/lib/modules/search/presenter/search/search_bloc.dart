import 'package:bloc/bloc.dart';
import 'package:gitHub_search/modules/search/domain/usecases/search_by_text.dart';
import 'package:gitHub_search/modules/search/presenter/state/search_state.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<String, SearchState> {

  final SearchByText usecases;
  SearchBloc(this.usecases) : super(SearchStart());

  @override
  Stream<SearchState> mapEventToState(String searchText) async* {
      yield SearchLoading();
      final result = await usecases(searchText);
      yield result.fold((l) => SearchError(l), (r) => SearchSucess(r));
  }

  @override
  Stream<Transition<String, SearchState>> transformEvents(Stream<String> events, transitionFn) {
    
    return super.transformEvents(events.debounceTime(Duration(milliseconds: 800)), transitionFn);
  }
  
}