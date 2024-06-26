import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:domain/environment/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cmuoi/di/di.dart';
import 'package:cmuoi/bootstrap.dart';

import 'common/app/bloc/app_bloc.dart';
import 'common/auth/auth.dart';

class AppInitializer {
  AppInitializer._internal();

  static final AppInitializer instance = AppInitializer._internal();

  Future<void> run(Env env) async {
    WidgetsFlutterBinding.ensureInitialized();
    await setupEnvironment(di, env: env);
    await DataLayer.init();
    await DomainLayer.init();
    configureDependencies();
    _configurations();
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc.to),
          BlocProvider<AppBloc>(create: (context) => AppBloc.to),
        ],
        child: const MyApp(),
      ),
    );
  }

  Future<void> _configurations() async {
    Bloc.observer = CustomBlocObserver();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
    );
  }
}
