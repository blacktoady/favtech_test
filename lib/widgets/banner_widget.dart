import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Image.asset(
        'assets/IMG_1716.JPG',
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}