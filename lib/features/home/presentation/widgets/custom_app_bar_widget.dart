// features/home/presentation/widgets/custom_app_bar_widget.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/theme/app_Theme.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/injection_container.dart';
import 'package:movie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie/routes/routes_names.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar({super.key})
      : preferredSize = const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Movies',
        style: GoogleFonts.almarai(
          fontSize: ResponsiveText.responsiveFontSize(context, 20),
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      actions: [
        IconButton(
          onPressed: () {
            sl.get<AuthBloc>().add(LogoutEvent());
            Modular.to.navigate(AppRoutes.anonymousOrAuthenticatedScreen);
          },
          icon: const Icon(Icons.logout, color: Colors.white),
        ),
      ],
    );
  }
}
