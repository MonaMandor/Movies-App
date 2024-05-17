// features/movie/presentation/widgets/popular_list_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/features/movie/domain/entities/movie_entity.dart';
import 'package:movie/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/features/movie/presentation/widgets/movie_widget.dart';
import 'package:movie/routes/routes_names.dart';

class BuildPopularList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movies = ReadContext(context).read<MovieBloc>().popularPagination; // Using ReadContext
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
