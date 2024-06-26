import 'package:core/core.dart';
import 'package:cmuoi/common/app/bloc/app_bloc.dart';
import 'package:cmuoi/common/app/bloc/app_state.dart';
import 'package:cmuoi/common/routes/routes.dart';
import 'package:cmuoi/ui/main/main_page.dart';
import 'package:cmuoi/ui/onboarding/onboarding_page.dart';
import 'package:cmuoi/resource/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cmuoi/common/common.dart';
import 'package:lottie/lottie.dart';

import '../../common/auth/auth.dart';
import '../login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _body();
    // return BlocBuilder<AuthBloc, AuthState>(
    //   builder: (context, state) {
    //     return AnimatedSwitcher(
    //       duration: const LongDuration(),
    //       transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(opacity: animation, child: child),
    //       child:  _body(),
    //     );
    //   },
    // );
  }

  Widget _body() {
    return Scaffold(
      backgroundColor: AppColor.primaryLight0,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.logo.image(),
            // Assets.animations.loadingWhite.lottie(),
          ],
        ),
      ),
    );
  }

  void _onAppListener(BuildContext context, AppState state) {
    if (!state.isOnBoarding) {
      AppNavigator.shared.pushNamed(RoutePath.onboarding);
      return;
    }
  }
}
