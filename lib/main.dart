// main.dart

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/core/theme/app_Theme.dart';
import 'package:movie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movie/injection_container.dart';
import 'package:movie/routes/module.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  Bloc.observer = MyBlocObserver();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => di.sl<AuthBloc>(),
      ),
      BlocProvider(create: (_) => di.sl<HomeBloc>()),
       BlocProvider(create: (_) => di.sl<MovieBloc>()),


    ],
    child: ModularApp(
      module: AppModule(),
      child: DevicePreview(
        enabled: true,
        builder: (BuildContext context) => const MyApp(),
      ),
    ),
  ));
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: AppTheme(context).theme,
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
