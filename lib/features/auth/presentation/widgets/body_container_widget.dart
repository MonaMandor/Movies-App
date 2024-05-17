// features/auth/presentation/widgets/body_container_widget.dart
// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie/core/theme/app_colors.dart';

class BodyContainer extends StatelessWidget {
  final Widget child;
  final Widget? header;
  final double height;
  final bool flag;

  BodyContainer({
    super.key,
    required this.child,
    this.header,
    required this.height,
    this.flag = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          if (header != null)
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF2F3142), Color(0xFF14151C)],
                ),
              ),
              child: header,
            ),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: height,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(1, 0),
                      colors: [Colors.black.withOpacity(0), AppColors.secondaryColor],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    border: Border.all(
                      color:AppColors.secondaryColor,
                      width: 1,
                    ),
                  ),
                  child: child,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

double pixelToDp(double pixel) {
  return pixel / 3.5;
}
