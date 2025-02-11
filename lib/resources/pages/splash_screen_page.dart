import 'package:dandaily/config/assets_image.dart';
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '/app/controllers/splash_screen_controller.dart';

class SplashScreenPage extends NyStatefulWidget<SplashScreenController> {
  static const path = '/splash-screen';

  SplashScreenPage({super.key}) : super(child: () => _SplashScreenPageState());
}

class _SplashScreenPageState extends NyState<SplashScreenPage> {
  /// [SplashScreenController] controller
  SplashScreenController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.navigateToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromARGB(255, 129, 184, 154),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return const Stack(
              children: [
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.45,
                    heightFactor: 0.7,
                    child:
                        Image(image: AssetImage(AssetImages.dandailyWhiteLogo)),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
