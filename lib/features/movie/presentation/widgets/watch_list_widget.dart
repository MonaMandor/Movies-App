// features/movie/presentation/widgets/watch_list_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie/features/movie/domain/entities/movies_entity.dart';
import 'package:movie/features/movie/domain/entities/add_delet_to_watch_list_params.dart';
import 'package:movie/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/features/movie/presentation/widgets/movie_widget.dart';
import 'package:movie/routes/routes_names.dart';

class WatchListWidget extends StatelessWidget {
  final MoviesEntity movies;
  final VoidCallback onScrollEnd;

  const WatchListWidget({
    Key? key,
    required this.movies,
    required this.onScrollEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent &&
            scrollNotification is ScrollEndNotification) {
          onScrollEnd();
        }
        return true;
      },
      child: ListView.separated(
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            BlocProvider.of<MovieBloc>(context).add(
              AddToWatchListEvent(
                params: AddDetetToWatchListParams(
                  movieId: movies.movies[index].id,
                  sessionId: BlocProvider.of<AuthBloc>(context)
                      .sessionEntity!
                      .sessionId,
                  accountId: BlocProvider.of<AuthBloc>(context).accountId!,
                  isAdd: false,
                ),
              ),
            );
          },
          child: MovieWidget(movie: movies.movies[index]),
        ),
        separatorBuilder: (context, index) =>
            SizedBox(height: context.propHeight(20)),
        itemCount: movies.movies.length,
      ),
    );
  }
}
