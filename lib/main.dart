import 'package:magicraft_wallet/controller/service/core.dart';
import 'package:magicraft_wallet/service/function/scroll.dart';
import 'package:magicraft_wallet/service/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoreAppController>(
      init: CoreAppController(),
      builder: (controller) => GetMaterialApp(
        title: 'Dompet Ku - most secure and reliable web3 wallet',
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        initialRoute: '/',
        getPages: appRoutes,
      ),
    );
  }
}
