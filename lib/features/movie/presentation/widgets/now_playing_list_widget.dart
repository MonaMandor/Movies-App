// features/movie/presentation/widgets/now_playing_list_widget.dart
import 'package:movie/features/movie/presentation/controllers/now_playing_pagination.dart';
import 'package:movie/injection_container.dart';import 'package:movie/injection_container.dart';

import '../../domain/entities/movie_entity.dart';
// features/movie/presentation/widgets/now_playing_list_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/features/movie/presentation/widgets/movie_widget.dart';
import 'package:movie/routes/routes_names.dart';

class BuildNowPlayingList extends StatelessWidget {
  NowPlayingPagination movies = sl.get<MovieBloc>().nowPlayingPagination;

  @override
  Widget build(BuildContext context) {
    movies.init();
    return PagedListView.separated(
      pagingController: movies.pagingController,
      shrinkWrap: true,
      builderDelegate: PagedChildBuilderDelegate<MovieEntity>(
        itemBuilder: (context, movie, index) => InkWell(
          onTap: () {
            Modular.to
                .pushNamed(AppRoutes.movieDetailsScreen, arguments: movie);
          },
          child: MovieWidget(movie: movie),
        ),
      ),


      separatorBuilder: (context, index) =>
          SizedBox(height: context.propHeight(20)),
    
    );
  }
}
