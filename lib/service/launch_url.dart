import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../navigator/navigator_key.dart';

class CustomURL {
  void launchCaller(String? phoneNumber) async {
    Uri url = Uri.parse('tel:$phoneNumber');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchURL(String link, {BuildContext? context}) async {
    Uri url = Uri.parse(link);

    if (await canLaunchUrl(url)) {
      try {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } catch (e) {
        print(e.toString());
      }
    } else {
      ScaffoldMessenger.of(context ?? NavigateKeys().navigationKey.currentContext!).showSnackBar(SnackBar(content: Text('Vui lòng thử lại sau')));
    }
  }
}
