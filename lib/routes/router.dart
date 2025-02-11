import 'package:dandaily/resources/pages/login_page.dart';
import 'package:dandaily/resources/pages/lupa_password_page.dart';
import 'package:dandaily/resources/pages/splash_screen_page.dart';
import '/resources/pages/home_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* App Router
|--------------------------------------------------------------------------
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "dart run nylo_framework:main make:page profile_page"
|
| * [Tip] Add authentication 🔑
| Run the below in the terminal to add authentication to your project.
| "dart run scaffold_ui:main auth"
|
| * [Tip] Add In-app Purchases 💳
| Run the below in the terminal to add In-app Purchases to your project.
| "dart run scaffold_ui:main iap"
|
| Learn more https://nylo.dev/docs/6.x/router
|-------------------------------------------------------------------------- */

appRouter() => nyRoutes((router) {
      router.route(SplashScreenPage.path, (context) => SplashScreenPage(),
          initialRoute: true);
      router.route(LoginPage.path, (context) => LoginPage());
      router.route(LupaPasswordPage.path, (context) => LupaPasswordPage());
      router.route(HomePage.path, (context) => HomePage());
    });
