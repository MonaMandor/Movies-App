// features/movie/presentation/pages/watch_list_screen.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie/features/movie/presentation/widgets/watch_list_widget.dart';
import 'package:movie/routes/routes_names.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen>
    with AutomaticKeepAliveClientMixin {
        @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    super.build(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color.fromARGB(255, 59, 5, 52), Color(0xFF14151C)],
          ),
        ),
        child: authBloc.sessionEntity == null
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Please login to see your watch list',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: context.propHeight(40),),
                    ElevatedButton(
                      onPressed: () {
                        Modular.to.navigate(AppRoutes.loginScreen);
                      },
                      child: const Text('Login'),
                    )
                  ],
                ),
              )
            : Padding(
              padding:  EdgeInsets.only(
                left: context.propWidth(10),
                right: context.propWidth(10),
                top: context.propHeight(30),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     SizedBox(height: context.propHeight(10),),
                  Text('Tab on the movie to remove from watch list', style: TextStyle(color: Colors.white),),
                 SizedBox(height: context.propHeight(20),),
                    WatchListWidget(),
                  ],
                ),
              ),
            ),
      ),
    );
  }

}