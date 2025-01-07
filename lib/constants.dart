import 'package:flutter/material.dart';

class AppAssets {
  static const String logo = 'web/icons/logo.png';
}

class AppLogo extends StatelessWidget {
  final double width;
  final double height;

  const AppLogo({super.key, this.width = 100, this.height = 100});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.logo, // Tanımladığımız logo yolu
      width: width,
      height: height,
    );
  }
}
