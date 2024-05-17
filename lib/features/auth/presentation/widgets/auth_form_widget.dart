// features/auth/presentation/widgets/auth_form_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/constansts/asset_manger.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/core/shared/shared_widget/Custom_button.dart';
import 'package:movie/core/shared/shared_widget/custom_user_name_filed.dart';
import 'package:movie/core/shared/shared_widget/password_field.dart';
import 'package:movie/core/theme/app_theme.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/features/auth/presentation/bloc/auth_bloc.dart';

class AuthForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AuthForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              AssetManger.logo,
              width: context.propWidth(100),
              height: context.propHeight(100),
            ),
          ),
          SizedBox(height: context.propHeight(6)),
          Text(
            ' ! Movie App',
            style: GoogleFonts.cinzelDecorative(
              fontSize: ResponsiveText.responsiveFontSize(context, 20),
              fontWeight: FontWeight.w900,
              color: AppColors.primaryTextColor,
            ),
          ),
          Text(
            'Login to Start your trip !',
            style: context.textTheme.bodySmall,
          ),
          SizedBox(height: context.propHeight(50)),
          CustomUserNameField(
            controller: emailController,
            titel: 'User Name',
          ),
          SizedBox(height: context.propHeight(20)),
          CustomPasswordField(
            controller: passwordController,
            titel: 'Password',
          ),
          SizedBox(height: context.propHeight(20)),
          SizedBox(height: context.propHeight(30)),
          CustomButton(
            title: 'Login',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                BlocProvider.of<AuthBloc>(context).add(
                  AuthenticateUserEvent(
                    password: passwordController.text,
                    username: emailController.text,
                  ),
                );
              }
            },
            backgroundColor: Color(0xFF232E37),
            height: context.propHeight(65),
            style: AppTheme(context)
                .theme
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.white),
          ),
          SizedBox(height: context.propHeight(30)),
        ],
      ),
    );
  }
}
