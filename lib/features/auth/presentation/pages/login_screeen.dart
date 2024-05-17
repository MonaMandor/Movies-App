// features/auth/presentation/pages/login_screeen.dart
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie/features/auth/presentation/widgets/auth_form_widget.dart';

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
                content: Text('Authenticating user...'),
                duration: Duration(seconds: 1),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          } else if (state is AuthenticateUserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('User authenticated successfully'),
                duration: Duration(seconds: 1),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          } else if (state is AuthenticateUserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: Duration(seconds: 2),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.propHeight(40),
            horizontal: context.propWidth(20),
          ),
          child: SingleChildScrollView(
            child: AuthForm(
              formKey: loginFormKey,
              emailController: emailController,
              passwordController: passwordController,
            ),
          ),
        ),
      ),
    );
  }
}
