import 'package:demoproapp/image_list.dart';
import 'package:flutter/material.dart';

class InternetNotFoundImageWidget extends StatelessWidget {
  const InternetNotFoundImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(ImageList.noInternet, width: 200, height: 200,));
  }
}