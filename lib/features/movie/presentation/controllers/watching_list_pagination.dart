// features/movie/presentation/controllers/watching_list_pagination.dart

import 'dart:developer';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie/features/movie/domain/entities/add_delet_to_watch_list_params.dart';
import 'package:movie/features/movie/domain/entities/get_wish_paramater.dart';
import 'package:movie/features/movie/domain/entities/movie_entity.dart';
import 'package:movie/features/movie/domain/usecases/add_to_watchList_use_case.dart';
import 'package:movie/features/movie/domain/usecases/get_witch_list_movies_use_case.dart';
import 'package:movie/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/injection_container.dart';

class WatchingListPagination {
  WatchingListPagination(this.getMoviesUseCase, this.addToWatchListUseCase);
  final GetWitchListMoviesUseCase getMoviesUseCase;
  final AddToWatchListUseCase addToWatchListUseCase;
  final pagingController = PagingController<int, MovieEntity>(firstPageKey: 1);
  final _pageSize = 6;

  void init() {
    pagingController.addPageRequestListener(_fetchPage);
  }

  void dispose() {
    pagingController.dispose();
  }

  void refresh() {
    pagingController.refresh();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final auth = sl.get<AuthBloc>();
      final r = await getMoviesUseCase.call(
        pageKey,
        GetoWatchListParams(
          accountId: auth.accountId ?? 0,
          sessionId: auth.sessionEntity?.sessionId ?? '',
        ),
      );
      r.fold(
        (l) {},
        (r) {
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

  Future delete(AddDetetToWatchListParams addDetetToWatchListParams) async {
    try {
      final r = await addToWatchListUseCase(addDetetToWatchListParams);
      r.fold(
        (l) {},
        (r) {
          pagingController.itemList?.removeWhere(
              (element) => element.id == addDetetToWatchListParams.movieId);
          pagingController.itemList = pagingController.itemList;
          pagingController.notifyListeners();
          sl.get<MovieBloc>().add(UpdateWatchListEvent()); // Emit event to update watch list
        },
      );
    } catch (error, s) {
      log('Exception: $error');
      log('Exception: $s');
      pagingController.error = error;
    }
  }
}