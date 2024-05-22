import 'package:flutter/material.dart';

class PageNotFoundImageWidget extends StatelessWidget {
  const PageNotFoundImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset("resources/images/no_data.avif"),
    );
  }
}
