import 'package:dandaily/config/tasks_provider.dart';
import 'package:dandaily/service/firebase_api.dart';
import 'package:dandaily/resources/pages/splash_screen_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import '/bootstrap/app.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'bootstrap/boot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();
  Nylo nylo = await Nylo.init(setup: Boot.nylo, setupFinished: Boot.finished);
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TasksProvider()),
        ],
        child: AppBuild(
          navigatorKey: NyNavigator.instance.router.navigatorKey,
          onGenerateRoute: nylo.router!.generator(),
          debugShowCheckedModeBanner: false,
          initialRoute: nylo.getInitialRoute(),
          navigatorObservers: nylo.getNavigatorObservers(),
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dandaily_ToDo",
      home: SplashScreenPage(),
    );
  }
}
