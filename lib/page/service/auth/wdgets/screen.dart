import 'package:magicraft_wallet/controller/page/service/auth.dart';
import 'package:magicraft_wallet/widget/assets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'action.dart';
import 'logo.dart';

Widget screenPage(
  AuthPageController controller,
  Size size,
) =>
    SizedBox.expand(
      child: Stack(
        children: [
          backScreen(size),
          logoApp(
            controller,
            size,
          ).animate(delay: 1000.ms).fadeIn(duration: 1500.ms),
          actionButton(controller, size),
        ],
      ),
    );
