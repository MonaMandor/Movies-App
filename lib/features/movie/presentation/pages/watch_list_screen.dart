// features/movie/presentation/pages/watch_list_screen.dart
import 'package:flutter/material.dart';import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie/features/movie/domain/entities/add_delet_to_watch_list_params.dart';
import 'package:movie/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/features/movie/presentation/widgets/watch_list_widget.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> with AutomaticKeepAliveClientMixin {
  int currentPage = 1;
  bool reachedEnd = false;

  @override
  void initState() {
    super.initState();
    fetchWatchListMovies();
  }

  void fetchWatchListMovies() {
    if (!reachedEnd) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        final authBloc = BlocProvider.of<AuthBloc>(context);
        BlocProvider.of<MovieBloc>(context).add(GetWatchListEvent(
          page: currentPage,
          params: AddDetetToWatchListParams(
            movieId: 0,
            sessionId: authBloc.sessionEntity!.sessionId,
            accountId: authBloc.accountId!,
            isAdd: false,
          ),
        ));
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin to work
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
            if (state is GetWatchListMoviesLoading && currentPage == 1) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetWatchListMoviesSuccess) {
              if (state.hasReachedMax) {
                reachedEnd = true;
              }
              return WatchListWidget(
                movies: state.movies,
                onScrollEnd: () {
                  if (!reachedEnd) {
                    currentPage++;
                    fetchWatchListMovies(); // Fetch more movies when scrolled to the end
                  }
                },
              );
            } else if (state is GetWatchListMoviesError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
