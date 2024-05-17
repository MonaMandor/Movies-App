// features/movie/presentation/controllers/popular_pagination.dart


import 'dart:developer';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie/core/apis/apis_url.dart';
import 'package:movie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie/features/movie/domain/entities/movie_entity.dart';
import 'package:movie/features/movie/domain/usecases/get_movies_use_case.dart';
import 'package:movie/injection_container.dart';

class PopularPagination {
  PopularPagination(this.getMoviesUseCase);
  final GetMoviesUseCase getMoviesUseCase;
  final pagingController = PagingController<int, MovieEntity>(firstPageKey: 1);
  final _pageSize = 6;

  void init() {
    pagingController.addPageRequestListener(_fetchPage);
  }

  void dispose() {
    pagingController.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final auth = sl.get<AuthBloc>();
      print(auth.accountId);
      print(auth.sessionEntity?.sessionId);
      final r = await getMoviesUseCase.call(
        pageKey,
        ApiUrl.popularMovies,
      );

      r.fold(
        (l) {},
        (r) {
          print(pageKey);
          var newItems = r.movies;
          final isLastPage = newItems.length < _pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(newItems, nextPageKey);
          }
        },
      );
    } catch (error, s) {
      log('Exception: $error');
      log('Exception: $s');
      pagingController.error = error;
    }
  }
}

