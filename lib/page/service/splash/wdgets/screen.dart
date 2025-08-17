import 'package:magicraft_wallet/controller/page/service/splash.dart';
import 'package:magicraft_wallet/widget/assets/background.dart';
import 'package:magicraft_wallet/widget/assets/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'logo.dart';

Widget screenPage(
  SplashPageController controller,
  Size size,
) =>
    Stack(
      children: [
        backScreen(size),
        backScreen(size, asset: bgPattern),
        logoApp(
          controller,
          size,
        ).animate(delay: 1000.ms).fadeIn(duration: 1500.ms),
      ],
    );
