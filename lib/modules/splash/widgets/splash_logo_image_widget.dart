import 'package:flutter/material.dart';

class SplashLogoImageWidget extends StatelessWidget {
  const SplashLogoImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: FlutterLogo(size: 200,),);
  }
}