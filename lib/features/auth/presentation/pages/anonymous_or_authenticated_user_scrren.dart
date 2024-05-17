// features/auth/presentation/pages/anonymous_or_authenticated_user_scrren.dart
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/core/constansts/asset_manger.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/core/shared/shared_widget/Custom_button.dart';
import 'package:movie/core/theme/app_Theme.dart';
import 'package:movie/core/theme/app_colors.dart';
import 'package:movie/features/auth/presentation/widgets/body_container_widget.dart';
import 'package:movie/routes/routes_names.dart';

class AnonymousOrAuthenticatedScreen extends StatelessWidget {
  const AnonymousOrAuthenticatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BodyContainer(
        height: context.propHeight(250),
        header: _buildHeader(context),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.propHeight(20),
        bottom: context.propHeight(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetManger.appLogo,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: context.propHeight(40)),
        Text(
          'Movie App !',
          style: GoogleFonts.cinzelDecorative(
            fontSize: ResponsiveText.responsiveFontSize(context, 32),
            fontWeight: FontWeight.w900,
            color: AppColors.primaryTextColor,
          ),
        ),
        SizedBox(height: context.propHeight(20)),
        _buildButton(
          context,
          title: 'Register immediately ?',
          onPressed: () => Modular.to.pushReplacementNamed(AppRoutes.loginScreen),
        ),
        SizedBox(height: context.propHeight(40)),
        _buildButton(
          context,
          title: 'Register later ?',
          onPressed: () => Modular.to.pushReplacementNamed(AppRoutes.homeLayout),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, {
    required String title,
    required VoidCallback onPressed,
  }) {
    return CustomButton(
      title: title,
      onPressed: onPressed,
      hasSahdow: true,
      backgroundColor: Colors.white,
      height: context.propHeight(65),
      style: AppTheme(context).theme.textTheme.bodyLarge?.copyWith(
        color: AppColors.primaryColor,
      ),
    );
  }
}
