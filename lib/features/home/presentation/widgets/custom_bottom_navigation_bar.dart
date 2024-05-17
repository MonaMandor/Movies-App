// features/home/presentation/widgets/custom_bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/core/theme/app_Theme.dart';
import 'package:movie/core/theme/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIdx;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.selectedIdx, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      itemCount: 2,
      gapLocation: GapLocation.none,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      leftCornerRadius: 20,
      rightCornerRadius: 20,
      backgroundColor: AppColors.primaryColor,
      height: context.propHeight(70),
      tabBuilder: (index, isActive) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(index == 0 ? Icons.movie : Icons.list,
                color: isActive ? Colors.white : Colors.black),
            SizedBox(height: context.propHeight(7)),
            Text(
              index == 0 ? 'Movies' : 'Watch List',
              style: GoogleFonts.almarai(
                fontSize: ResponsiveText.responsiveFontSize(context, 12),
                fontWeight: FontWeight.w400,
                color: isActive ? Colors.white : Colors.black,
              ),
            ),
          ],
        );
      },
      activeIndex: selectedIdx,
      onTap: onTap,
    );
  }
}
