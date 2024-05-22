import 'package:demoproapp/modules/error/widgets/page_not_found_image_widget.dart';
import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatefulWidget {
  const PageNotFoundScreen({super.key});

  @override
  State<PageNotFoundScreen> createState() => _PageNotFoundScreenState();
}

class _PageNotFoundScreenState extends State<PageNotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PageNotFoundImageWidget(),
    );
  }
}