// features/movie/presentation/pages/movie_details_screen.dart
// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/core/shared/shared_widget/custom_button.dart';
import 'package:movie/core/shared/shared_widget/special_app_bar.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie/features/movie/domain/entities/movie_entity.dart';
import 'package:movie/features/movie/domain/entities/add_delet_to_watch_list_params.dart';
import 'package:movie/features/movie/presentation/bloc/movie_bloc.dart';

class MovieDetailsScreen extends StatefulWidget {
  final MovieEntity movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MovieBloc, MovieState>(
        bloc: BlocProvider.of<MovieBloc>(context),
        listener: (context, state) {
          if (state is AddToWatchListLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Adding to watch list...'),
                duration: const Duration(seconds: 1),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          } else if (state is AddToWatchListSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Added to watch list successfully'),
                duration: const Duration(seconds: 2),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          } else if (state is AddToWatchListError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 2),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          }
        },
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color.fromARGB(255, 59, 5, 52), Color(0xFF14151C)],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.propHeight(300),
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Image.network(
                        widget.movie.posterPath,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: context.propHeight(226),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: context.propWidth(20)),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                width: context.propWidth(120),
                                height: context.propHeight(120),
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(widget.movie.backdroPath),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: const CircleBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: context.propWidth(30),
                                bottom: context.propHeight(30),
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      '${widget.movie.voteAverage}',
                                      
                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
                                    ),
                                    SizedBox(width: context.propWidth(10)),
                                    RatingBarIndicator(
                                      itemBuilder: (context, index) {
                                        return const Icon(
                                          Icons.star,
                                          color: Color.fromARGB(255, 241, 218, 5),
                                        );
                                      },
                                      rating: widget.movie.voteAverage / 2,
                                      itemSize: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: context.propHeight(10),
                          left: context.propWidth(25),
                        ),
                        child: const SpecialAppBar(title: ''),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: context.propWidth(20),
                    left: context.propWidth(20),
                    top: context.propHeight(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movie.title,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
                      ),
                      SizedBox(height: context.propHeight(5)),
                      Text(
                        widget.movie.overview,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                      ),
                      SizedBox(height: context.propHeight(21)),
                      Container(
                        width: double.infinity,
                        height: 1,
                        decoration: const BoxDecoration(color: Color(0xFFF4F5F7)),
                      ),
                      SizedBox(height: context.propHeight(30)),
                      CustomButton(
                        title: 'Add to watch list',
                        onPressed: () {
                          final authBloc = BlocProvider.of<AuthBloc>(context);
                          if (authBloc.sessionEntity?.sessionId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Please login to add to watch list'),
                                duration: const Duration(seconds: 2),
                                backgroundColor: AppColors.primaryColor,
                              ),
                            );
                          } else {
                            BlocProvider.of<MovieBloc>(context).add(
                              AddToWatchListEvent(
                                params: AddDetetToWatchListParams(
                                  movieId: widget.movie.id,
                                  sessionId: authBloc.sessionEntity!.sessionId,
                                  accountId: authBloc.accountId!,
                                  isAdd: true,
                                  
                                ),
                              ),
                            );
                          }
                        },
                      
                        backgroundColor: AppColors.primaryColor,
                        height: context.propHeight(65),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
