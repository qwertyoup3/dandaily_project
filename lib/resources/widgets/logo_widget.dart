import 'package:dandaily/config/assets_image.dart';
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.height, this.width});
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetImages.dandailyLogo,
      height: height ?? 100,
      width: width ?? 100,
    ).localAsset();
  }
}
