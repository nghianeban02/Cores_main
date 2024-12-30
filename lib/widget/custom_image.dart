import 'package:cores_project/utils/app_assets.dart';
import 'package:flutter/material.dart';

class CustomImage {
  Widget assetImage(String assetName) {
    return Image.asset(assetName);
  }

  BoxDecoration backgroudImage() {
    return const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              AppAssets.brHome,
            ),
            fit: BoxFit.fill));
  }
}
