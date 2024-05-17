// features/movie/presentation/widgets/now_playing_list_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/features/movie/domain/entities/movies_entity.dart';
import 'package:movie/features/movie/presentation/widgets/movie_widget.dart';
import 'package:movie/routes/routes_names.dart';

class BuildNowPlayingList extends StatelessWidget {
  final MoviesEntity movies;
  final VoidCallback onScrollEnd;

  const BuildNowPlayingList({
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
        key: PageStorageKey('NowPlayingList'),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Modular.to.pushNamed(AppRoutes.movieDetailsScreen,
                arguments: movies.movies[index]);
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
