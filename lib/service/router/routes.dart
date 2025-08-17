import 'package:dompet_ku/page/detail/account/main.dart';
import 'package:dompet_ku/page/detail/bookmark/main.dart';
import 'package:dompet_ku/page/detail/nft/main.dart';
import 'package:dompet_ku/page/detail/other/main.dart';
import 'package:dompet_ku/page/detail/send/main.dart';
import 'package:dompet_ku/page/detail/token/main.dart';
import 'package:dompet_ku/page/main/main.dart';
import 'package:dompet_ku/page/service/auth/main.dart';
import 'package:dompet_ku/page/service/create_wallet/main.dart';
import 'package:dompet_ku/page/service/import_wallet/main.dart';
import 'package:dompet_ku/page/service/info/main.dart';
import 'package:get/get.dart';
import 'package:dompet_ku/page/service/splash/main.dart';

var appRoutes = <GetPage>[
  // Service Page
  GetPage(
    name: '/',
    page: () => const SplashPage(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/splash',
    page: () => const SplashPage(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/auth',
    page: () => const AuthPage(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/import-wallet',
    page: () => const ImportWalletPage(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/create-wallet',
    page: () => const CreateWalletPage(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/info',
    page: () => const InfoPage(),
    transition: Transition.fadeIn,
  ),

  // Main Page
  GetPage(
    name: '/main',
    page: () => const MainPage(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/account',
    page: () => const AccountPage(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/send',
    page: () => const SendPage(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/token',
    page: () => const TokenPage(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/nft',
    page: () => const NftPage(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/other',
    page: () => const OtherPage(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: '/bookmark',
    page: () => const BookmarkPage(),
    transition: Transition.fadeIn,
  ),
];
