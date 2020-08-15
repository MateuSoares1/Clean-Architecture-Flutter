import 'package:dartz/dartz.dart';
import 'package:gitHub_search/modules/search/domain/entities/result_search.dart';
import 'package:gitHub_search/modules/search/domain/errors/errors.dart';

abstract class  SearchRepository {
  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText); 
}