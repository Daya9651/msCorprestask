import 'package:flutter/material.dart';

Widget constBackgroundContainer({Widget? child}) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
            "assets/images/background.jpg"
          // ImageString.background,
          // ImageString.backgroundErpImage,
          // fit: BoxFit.cover,
        ),
        fit: BoxFit.fill,
      ),
    ),
    child: child,
  );
}