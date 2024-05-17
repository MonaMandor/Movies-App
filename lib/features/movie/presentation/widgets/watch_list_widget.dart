// features/movie/presentation/widgets/watch_list_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie/features/movie/domain/entities/movie_entity.dart';
import 'package:movie/features/movie/domain/entities/add_delet_to_watch_list_params.dart';
import 'package:movie/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/features/movie/presentation/widgets/movie_widget.dart';
import 'package:movie/injection_container.dart';

class WatchListWidget extends StatefulWidget {

  WatchListWidget({super.key});

  @override
  State<WatchListWidget> createState() => _WatchListWidgetState();
}

class _WatchListWidgetState extends State<WatchListWidget> {
  final movies = sl.get<MovieBloc>().watchingListPagination;

  @override
  Widget build(BuildContext context) {
    movies.init();
    return BlocListener<MovieBloc, MovieState>(
      listener: (context, state) {
        if (state is AddToWatchListSuccess) {
          movies.refresh();
        }
      },
      child: PagedListView.separated(
        pagingController: movies.pagingController,
        shrinkWrap: true,
   
        builderDelegate: PagedChildBuilderDelegate<MovieEntity>(
          itemBuilder: (context, movie, index) => InkWell(
            onTap: () {
              movies.delete(AddDetetToWatchListParams(
                movieId: movie.id,
                sessionId: BlocProvider.of<AuthBloc>(context).sessionEntity!.sessionId,
                accountId: BlocProvider.of<AuthBloc>(context).accountId!,
                isAdd: false,
              ));
            },
            child: MovieWidget(movie: movie),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(height: context.propHeight(20)),
      ),
    );
  }
 
}