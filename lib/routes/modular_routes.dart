// routes/modular_routes.dart
// ignore_for_file: prefer_const_constructors// ignore_for_file: prefer_const_constructors
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/features/auth/presentation/pages/anonymous_or_authenticated_user_scrren.dart';
import 'package:movie/features/auth/presentation/pages/login_screeen.dart';
import 'package:movie/features/auth/presentation/pages/splash_screen.dart';
import 'package:movie/features/home/presentation/pages/home_layout.dart';
import 'package:movie/features/movie/domain/entities/movie_entity.dart';
import 'package:movie/features/home/presentation/pages/Movies_screen.dart';
import 'package:movie/features/movie/presentation/pages/movie_details_screen.dart';
import 'package:movie/routes/routes_names.dart';
import 'package:modular_interfaces/src/route/modular_arguments.dart';

List<ModularRoute> modularRoutes = <ChildRoute<dynamic>>[
  ChildRoute<dynamic>(
    AppRoutes.start,
    child: (_, ModularArguments args) =>  SplashScreen(),
    transition: TransitionType.upToDown,
  ),
  ChildRoute<dynamic>(
    AppRoutes.anonymousOrAuthenticatedScreen,
    child: (_, ModularArguments args) => const AnonymousOrAuthenticatedScreen(),
    transition: TransitionType.rightToLeft,
  ),
  ChildRoute<dynamic>(
    AppRoutes.loginScreen,
    child: (_, ModularArguments args) => LoginScreen(),
    transition: TransitionType.rightToLeft,
  ),

   ChildRoute<dynamic>(
    AppRoutes.homeLayout,
    child: (_, ModularArguments args) => HomeLayout(),
    transition: TransitionType.rightToLeft,),

   ChildRoute<dynamic>(
    AppRoutes.movieDetailsScreen,
    child: (_, ModularArguments args) => MovieDetailsScreen( movie: args.data as MovieEntity,),
    transition: TransitionType.rightToLeft,)
];
