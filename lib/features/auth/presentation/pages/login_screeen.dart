// features/auth/presentation/pages/login_screeen.dart
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/constansts/asset_manger.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/core/shared/shared_widget/Custom_button.dart';
import 'package:movie/core/shared/shared_widget/custom_user_name_filed.dart';
import 'package:movie/core/shared/shared_widget/password_field.dart';
import 'package:movie/core/theme/app_Theme.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/features/auth/presentation/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocListener<AuthBloc, AuthState>(
        bloc: BlocProvider.of<AuthBloc>(context),
        listener: (context, state) {
          if (state is AuthenticateUserLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('authenticating user...'),
                duration: Duration(seconds: 2),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          } else if (state is AuthenticateUserSuccess) {
            // Modular.to.pushNamed(AppRoutes.homeScreen);
            final authBloc = BlocProvider.of<AuthBloc>(context);
            final accountId = authBloc.accountId;
            print('account id: $accountId');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('User authenticated successfully'),
                duration: Duration(seconds: 2),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          } else if (state is AuthenticateUserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 2),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.only(
              top: context.propHeight(60),
              bottom: context.propHeight(20),
              left: context.propWidth(20),
              right: context.propWidth(20)),
          child: SingleChildScrollView(
            child: Form(
                key: loginFormKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(AssetManger.logo,
                          width: context.propWidth(100),
                          height: context.propHeight(100)),
                    ),
                    SizedBox(
                      height: context.propHeight(6),
                    ),
                    Text(
                      ' ! Movie App',
                      style: GoogleFonts.cinzelDecorative(
                        fontSize:
                            ResponsiveText.responsiveFontSize(context, 20),
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                    Text(
                      'Login to Start your trip !',
                      style: context.textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: context.propHeight(50),
                    ),
                    CustomUserNameField(
                      controller: emailController,
                      titel: 'User Name',
                    ),
                    SizedBox(
                      height: context.propHeight(20),
                    ),
                    CustomPasswordField(
                      controller: passwordController,
                      titel: 'Password',
                    ),
                    SizedBox(
                      height: context.propHeight(20),
                    ),
                    SizedBox(
                      height: context.propHeight(30),
                    ),
                    CustomButton(
                        title: 'Login',
                        onPressed: () {
                          if (loginFormKey.currentState!.validate()) {
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
                            ?.copyWith(color: Colors.white)),
                    SizedBox(
                      height: context.propHeight(30),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final String icon;
  final String title;
  const SocialLoginButton({
    required this.icon,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.propWidth(150),
      height: context.propHeight(56),
      padding: EdgeInsets.symmetric(
          horizontal: context.propWidth(32), vertical: context.propHeight(16)),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.50, color: Color(0xFFFFB319)),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Row(
        children: [
          Image.asset(icon,
              width: context.propWidth(20), height: context.propHeight(20)),
          SizedBox(width: context.propWidth(8)),
          Text(title,
              style: context.textTheme.bodySmall?.copyWith(
                  color: Color(0xFF0C0C0C),
                  fontSize: 14,
                  fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }
}
