import 'package:demoproapp/image_list.dart';
import 'package:flutter/material.dart';

class SplashLogoImageWidget extends StatelessWidget {
  const SplashLogoImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(ImageList.logo, width: 200, height: 200,));
  }
}