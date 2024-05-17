// features/home/presentation/pages/home_layout.dart
import 'package:flutter/material.dart';
import 'package:movie/features/home/presentation/widgets/custom_app_bar_widget.dart';
import 'package:movie/features/home/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:movie/features/home/presentation/pages/movies_screen.dart';
import 'package:movie/features/movie/presentation/pages/watch_list_screen.dart';
import 'package:movie/core/theme/app_colors.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIdx = 0;

  final List<Widget> screens = [MoviesScreen(), WatchListScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: AppColors.scaffoldBackground,
      body: IndexedStack(
        index: selectedIdx,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIdx: selectedIdx,
        onTap: (index) => setState(() => selectedIdx = index),
      ),
    );
  }
}
