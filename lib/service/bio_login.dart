import 'package:local_auth/local_auth.dart';

class BioLogin {
  static final _auth = LocalAuthentication();
  static Future<bool> _canAuthenticate() async {
    return await _auth.canCheckBiometrics;
  }

  static Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;
      return await _auth.authenticate(localizedReason: 'Đăng nhập bằng sinh trắc học', options: AuthenticationOptions(useErrorDialogs: true, stickyAuth: true));
    } catch (e) {
      return false;
    }
  }
}
