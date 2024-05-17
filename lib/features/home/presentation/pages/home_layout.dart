// features/home/presentation/pages/home_layout.dart
// ignore_for_file: use_key_in_widget_constructors// ignore_for_file: use_key_in_widget_constructors

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/core/theme/app_Theme.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/features/home/presentation/pages/Movies_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({
    super.key,
  });
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIdx = 0;

  final List<Widget> screens = [
   MoviesScreen(),
    Container(color: Colors.blue),
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  late Widget currentScreen;

  @override
  void initState() {
    super.initState();
    currentScreen = Container();
  }

  @override
  Widget build(BuildContext context) {
    // Initially, no item is selected
    Widget currentScreen = Container();
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Stack(children: [
        screens[selectedIdx],
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedBottomNavigationBar.builder(
            itemCount: 2,
            gapLocation: GapLocation.none,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            leftCornerRadius: 20,
            rightCornerRadius: 20,
            backgroundColor: AppColors.primaryColor,
            height: context.propHeight(50),

            tabBuilder: (index, isActive) {
              return Column(
     
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Icon(
                    index == 0
                        ? Icons.video_call
                        :  Icons.watch_later
                            ,
                    color: isActive
                        ? AppColors.secondaryColor
                        : AppColors.fourthTextColor,
                   
                  ),
                  SizedBox(height: context.propHeight(7)),
                  Text(
                    index == 0 ? 'Watch' : 'Watch Later',
                    style: GoogleFonts.almarai(
                      fontSize: ResponsiveText.responsiveFontSize(context, 12),
                      fontWeight: FontWeight.w400,
                      color: isActive
                          ? AppColors.secondaryColor
                          : AppColors.fourthTextColor,
                    ),
                  ),
                ],
              );
            },
            activeIndex: selectedIdx,

            onTap: (index) => setState(() => selectedIdx = index),
       
          ),
        ),
      ]),
     
    );
  }
}
