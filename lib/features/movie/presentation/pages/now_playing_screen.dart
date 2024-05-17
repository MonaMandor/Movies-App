// features/movie/presentation/pages/now_playing_screen.dart
import 'package:flutter/material.dart';import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/apis/apis_url.dart';
import 'package:movie/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/features/movie/presentation/widgets/now_playing_list_widget.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({Key? key}) : super(key: key);

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> with AutomaticKeepAliveClientMixin {
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  void fetchMovies() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
     
      context.read<MovieBloc>().add(GetMoviesEvent(page: currentPage, moviesType: ApiUrl.nowPlayingMovies));
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color.fromARGB(255, 59, 5, 52), Color(0xFF14151C)],
          ),
        ),
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is GetMoviesLoading && currentPage == 1) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetMoviesLoaded) {
              return BuildNowPlayingList(
                movies: state.movies,
                onScrollEnd: () {
                  currentPage++;
                  fetchMovies();
                },
              );
            } else if (state is GetMoviesError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
