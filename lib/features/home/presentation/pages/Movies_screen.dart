// features/home/presentation/pages/Movies_screen.dart
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/features/movie/presentation/pages/now_playing_screen.dart';
import 'package:movie/features/movie/presentation/pages/popular_screen.dart';
import 'package:movie/features/movie/presentation/pages/watch_list_screen.dart';
import 'package:movie/features/home/presentation/widgets/tab_bar_widget.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MoviesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: EdgeInsets.only(
            top: context.propHeight(60),
            left: context.propWidth(10),
            right: context.propWidth(10),
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white, width: 2),
                  color: Colors.white.withOpacity(0.8),
                ),
                height: context.propHeight(60),
                width: double.infinity,
                child: TabBarWidget(
                  tabs: const [
                    "Now playing",
                    "Popular",
                    "Top Rated",
                    "Upcoming"
                  ],
                  controller: _tabController,
                ),
              ),
              Expanded(
                // Use Expanded to constrain the height of TabBarView
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    NowPlayingScreen(),
                    WatchListScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
