import 'package:dandaily/config/assets_image.dart';
import 'package:dandaily/config/colors_config.dart';
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
    controller.navigateToSignUp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: SetColors.secondaryColor,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return const Stack(
              children: [
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.50,
                    heightFactor: 0.15,
                    child:
                        Image(image: AssetImage(AssetImages.dandailyGreenLogo)),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
