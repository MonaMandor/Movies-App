// features/auth/presentation/pages/splash_screen.dart

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/core/constansts/asset_manger.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/routes/routes_names.dart';
import 'package:movie/features/auth/presentation/bloc/auth_bloc.dart'; // Adjust the path as necessary
// features/auth/presentation/pages/splash_screen.dart




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _dotController1;
  late AnimationController _dotController2;
  late AnimationController _dotController3;

  @override
  void initState() {
    super.initState();

    // Dispatch CheckLoginEvent
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<AuthBloc>(context).add(CheckLoginEvent());
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _dotController1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _dotController2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true, period: const Duration(milliseconds: 333));

    _dotController3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true, period: const Duration(milliseconds: 667));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _dotController1.dispose();
    _dotController2.dispose();
    _dotController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(1, 0),
            colors: [
              Colors.black.withOpacity(0),
              Color(0xFF7F00FF),
            ],
          ),
        ),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is CheckLoginFailure) {
              Future.delayed(Duration(seconds: 3), () {
                Modular.to.pushNamed(AppRoutes.anonymousOrAuthenticatedScreen);
              });
            } else if (state is CheckLoginSuccess) {
              Future.delayed(Duration(seconds: 3), () {
                Modular.to.pushNamed(AppRoutes.homeLayout);
              });
            }
          },
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  AssetManger.logo,
                  fit: BoxFit.cover,
                ),
              ),
              // Loading animation with dots
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _dotController1,
                      builder: (_, child) {
                        return Opacity(
                          opacity: _dotController1.value,
                          child: child,
                        );
                      },
                      child: _buildDot(),
                    ),
                    AnimatedBuilder(
                      animation: _dotController2,
                      builder: (_, child) {
                        return Opacity(
                          opacity: _dotController2.value,
                          child: child,
                        );
                      },
                      child: _buildDot(),
                    ),
                    AnimatedBuilder(
                      animation: _dotController3,
                      builder: (_, child) {
                        return Opacity(
                          opacity: _dotController3.value,
                          child: child,
                        );
                      },
                      child: _buildDot(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
