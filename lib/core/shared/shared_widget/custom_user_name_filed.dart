// core/shared/shared_widget/custom_user_name_filed.dart
import 'package:flutter/material.dart';
import 'package:movie/core/constansts/asset_manger.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/core/shared/shared_widget/customTextFormFiled.dart';
import 'package:movie/core/theme/app_Theme.dart';
import 'package:movie/core/theme/app_colors.dart';


class CustomUserNameField extends StatelessWidget {
  final TextEditingController controller;
  final String titel ;
 
  const CustomUserNameField({super.key, 
    required this.controller, required this.titel,
    
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         titel,
         style: AppTheme(context).theme.textTheme.titleMedium,
        ),
        SizedBox(height: context.propHeight(18)),
        CustomTextField(
          obscureText: false,

          
          suffix: Image.asset(
            AssetManger.userName,
            color: AppColors.primaryColor,
           
          ),
          
         // height: context.propHeight(52),
          fillColor: Color(0xFF7F00FF),
    
          controller: controller,
          keyboardType: TextInputType.name,
          
         validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your UserName';
            }
            return null;
          },
        hintText:  'Enter your User name',
          hintStyle: AppTheme(context).theme.inputDecorationTheme.hintStyle,
        ),
      ],
    );
  }
}
