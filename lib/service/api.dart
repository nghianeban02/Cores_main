class Api {
  static const String baseApi = 'https://cores-api.ewarrantysystem.com/';

  //
  static const String apiLogin = 'identity/v1/Account/Login';
  static const String apiRegister = 'identity/v1/Partner/ApiForMobile';
  static const String apiInfoUser = 'identity/v1/Account/InfoAccount';
  static const String apiChangePassword = 'identity/v1/Account/UpdatePassword';
  static const String apiForgetPassword = 'identity/v1/User/ForgotPassword';
  static const String apiRegisterKhachle = 'identity/v1/User/CustomerRegister';
  static const String apiGetInfo = 'identity/v1/User/id/{id}';
  static const String apiUpdatestatus = 'identity/v1/User/{id}/UpdateStatus';
  static const String apiListStation = 'identity/v1/Asc/GetAll';
  //
  //\
  static const String apiListCityAll = 'master-data/v1/City/GetAll';
  static const String apiListCity = 'master-data/v1/City/List';
  static const String apiListDistrist = 'master-data/v1/District/List';
  static const String apiListWard = 'master-data/v1/Ward/List';
  static const String apiListCategory = 'master-data/v1/Category/GetAll';
  static const String apiListModel = 'master-data/v1/Models';

  //
  static const String apiAddActivate = 'call-center/v1/Active/AddHasCode';
  static const String apiAddActivateNotToken = "call-center/v1/Active/WebAdd";
  static const String apiListActivate = 'call-center/v1/Active/List';
  static const String apiSum = 'call-center/v1/Active/SumAccumulateApp';
  static const String apiModelbySerial = 'call-center/v1/ActiveData/';
  static const String apiUploadImage = 'file-management/v1/ManageImage';
//otp
  static const String sendOtp = 'identity/v1/OTP';
  static const String checkOtp = 'identity/v1/OTP/Check';

  static String convertURL(String path) {
    return baseApi + path;
  }
}
