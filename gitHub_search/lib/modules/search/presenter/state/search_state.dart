import 'package:gitHub_search/modules/search/domain/entities/result_search.dart';
import 'package:gitHub_search/modules/search/domain/errors/errors.dart';


abstract class SearchState {
  
}



class SearchSucess implements SearchState {
  final List<ResultSearch> list;

  SearchSucess(this.list);
}

class SearchStart implements SearchState {
  
}

class SearchLoading implements SearchState {
  
}

class SearchError implements SearchState {
  final FailureSearch error;

  SearchError(this.error);

}