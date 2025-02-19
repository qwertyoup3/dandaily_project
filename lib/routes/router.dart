import 'package:dandaily/resources/pages/dashboard_page.dart';
import 'package:dandaily/resources/pages/sign_in_page.dart';
import 'package:dandaily/resources/pages/sign_up_pages.dart';
import 'package:dandaily/resources/pages/splash_screen_page.dart';
import 'package:dandaily/resources/pages/todo_create_page.dart';
import 'package:dandaily/resources/pages/todo_detail_page.dart';

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
      router.add(TodoCreatePage.path);
      router.add(UpdatedTodoDetailPage.path);
      router.add(DashboardPage.path);
      router.add(SignUpPage.path);
      router.add(SignInPage.path);
    });
