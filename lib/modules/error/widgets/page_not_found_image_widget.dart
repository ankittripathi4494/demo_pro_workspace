import 'package:demoproapp/image_list.dart';
import 'package:flutter/material.dart';

class PageNotFoundImageWidget extends StatelessWidget {
  const PageNotFoundImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(ImageList.pageNotFound, width: 200, height: 200,));
  }
}
