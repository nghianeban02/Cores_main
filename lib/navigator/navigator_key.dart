import 'package:flutter/widgets.dart';

class NavigateKeys {
  static final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navKey;
}
