// core/shared/shared_widget/special_app_bar.dart

// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/core/theme/app_Theme.dart';
import 'package:movie/core/theme/app_colors.dart';


class SpecialAppBar extends StatelessWidget {
  final String title;

  const SpecialAppBar({super.key, required this.title, 
  
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.propHeight(60),
      child: Row(
        children: [
          InkWell(
            onTap: (() {
              //back
              Navigator.of(context).pop();
            }),
            child: Container(
              width: context.propWidth(40),
              height: context.propHeight(40),
              decoration: ShapeDecoration(
                color: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primaryTextColor,
                  size: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            width: context.propWidth(80),
          ),
          Text(title,
               style: AppTheme(context).theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.primaryTextColor,)
          
          )
        ],
      ),
    );
  }
}
