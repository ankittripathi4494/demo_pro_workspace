
import 'package:flutter/material.dart';
import '../widgets/internet_not_found_image_widget.dart';

class InternetNotFoundScreen extends StatefulWidget {
  const InternetNotFoundScreen({super.key});

  @override
  State<InternetNotFoundScreen> createState() => _InternetNotFoundScreenState();
}

class _InternetNotFoundScreenState extends State<InternetNotFoundScreen> {

      @override
  void initState() {
   
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: InternetNotFoundImageWidget(),
    );
  }
}