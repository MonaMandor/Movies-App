// features/movie/presentation/pages/Up_coming_movies_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/features/movie/presentation/widgets/up_coming_movies_widget.dart';
import 'package:movie/injection_container.dart';

class UpComingScreen extends StatefulWidget {
  const UpComingScreen({super.key});

  @override
  State<UpComingScreen> createState() => _UpComingScreenState();
}

class _UpComingScreenState extends State<UpComingScreen>
    with AutomaticKeepAliveClientMixin {
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
        child: BlocProvider(
          create: (context) => sl<MovieBloc>()..upComingPagination.init(),
          child: BuildUpComingMoviesWidget(),
        ),
      ),
    );
  }
}
