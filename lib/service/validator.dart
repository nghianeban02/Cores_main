import 'package:cores_project/utils/utils.dart';

import '../widget/custom_text.dart';

int MAX_LENGTH_CHARACTER = 255;

class Validator {
  static validateEmail(String? value) {
    if (!Utils.isNullOrEmpty(value)) {
      if (value!.length > MAX_LENGTH_CHARACTER) {
        return 'Nhập tối đa 50 kí tự';
      } else if (RegExp(EMAIL_REGEXP).hasMatch(value) == false) {
        return 'Vui lòng kiểm tra email';
      }
    } else {
      return 'Vui lòng nhập email';
    }
  }

  static checkNull(String? value, {String? messageErrorNull, int? maxChar, int? minChar}) {
    if (value == null || value.isEmpty || value == ' ' || value.contains('  ') || value == 'null') {
      return messageErrorNull;
    }
    if (!Utils.isNullOrEmpty(maxChar) && value.length > maxChar!) {
      return 'Nhập tối đa $maxChar kí tự';
    }
    if (!Utils.isNullOrEmpty(minChar) && value.length < minChar!) {
      return 'Nhập tối thiểu $minChar kí tự';
    }
    return null;
  }

  static checkPhoneNumber(String? value) {
    if (value == null || (value.length <= 8 || value.length > 12 || value.isEmpty)) {
      return 'Vui lòng kiểm tra số điện thoại';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value.replaceFirst('-', '').replaceFirst('+', ''))) {
      return "Vui lòng nhập số";
    }
    return null;
  }

  static checkPassword(String? value) {
    if (Utils.isNullOrEmpty(value) || value == ' ' || value!.contains('  ')) {
      return 'Vui lòng điền mật khẩu';
    } else if (value.length > MAX_LENGTH_CHARACTER) {
      return 'Nhập tối đa $MAX_LENGTH_CHARACTER kí tự';
    } else if (RegExp(EMOJI_REGEXP).hasMatch(value)) {
      return 'Không chèn kí tự đặt biệt';
    } else if (value.length < 6) {
      return 'Mật khẩu tối thiểu 6 kí tự';
    }
    return null;
  }

  static checkInputNumber(String? value, {double? min, double? max, double maxLength = 14}) {
    if (Utils.isNullOrEmpty(value)) {
      return 'Không thể để trống';
    }
    if (double.parse(value!) <= 0) {
      return 'Số  phải lớn hơn 0';
    }
    if (value.length >= maxLength) {
      return 'Nhập tối đa $maxLength kí tự';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "Phải nhập số nguyên";
    }
    if (!Utils.isNullOrEmpty(min) && double.parse(value) < (min ?? 0)) {
      return 'Không nhỏ hơn $min';
    }
    if (!Utils.isNullOrEmpty(max) && double.parse(value) > (max ?? 0)) {
      return 'Không lớn hơn $max';
    }
    return null;
  }
}
