import 'package:cores_project/bloc/account/account_cubit.dart';
import 'package:cores_project/model/info_user_model.dart';
import 'package:cores_project/storage/app_preferences.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/custom_button.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  late InfoUserModel infoUserModel;
  final controllerName = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerAddress = TextEditingController();
  final controllerCCCD = TextEditingController();
  final controllerBankName = TextEditingController();
  final controllerAccountNumber = TextEditingController();
  bool isDoiTac = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    infoUserModel = BlocProvider.of<AccountCubit>(context).infoUserModel;
    isDoiTac = infoUserModel.idGroupUser == 'DOITAC';
    if (infoUserModel.staff != null) {
      controllerName.text = infoUserModel.staff!.fullName ?? '';
      controllerPhone.text = infoUserModel.staff!.phone ?? '';
      controllerAddress.text = infoUserModel.staff!.fullAddress ?? '';
      controllerCCCD.text = infoUserModel.staff!.noIdentity ?? '';
      controllerEmail.text = infoUserModel.staff!.mail ?? '';
    } else {
      controllerName.text = infoUserModel.fullname ?? '';
      controllerPhone.text = infoUserModel.username ?? '';
    }

    //  controllerBankName.text=infoUserModel.staff.
  }

  @override
  Widget build(BuildContext context) {
    print(AppPreferencesImpl().getToken);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thông tin cá nhân'),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: AppColors.greyLight,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.all(40.0),
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://thumbs.dreamstime.com/b/male-avatar-icon-flat-style-male-user-icon-cartoon-man-avatar-hipster-vector-stock-91462914.jpg'),
                    ),
                  ),
                ),
                CustomTextField(
                  paddingVer: 15,
                  controller: controllerName,
                  typeInput: TypeInput.text,
                  labelText: 'Họ tên',
                ),
                CustomTextField(
                  paddingVer: 15,
                  controller: controllerPhone,
                  typeInput: TypeInput.phone,
                  labelText: 'Số điện thoại',
                  readOnly: true,
                ),
                if (isDoiTac) ...{
                  CustomTextField(
                    paddingVer: 15,
                    controller: controllerEmail,
                    typeInput: TypeInput.text,
                    labelText: 'Email',
                  ),
                  CustomTextField(
                    paddingVer: 15,
                    controller: controllerAddress,
                    typeInput: TypeInput.text,
                    labelText: 'Địa chỉ',
                  ),

                  CustomTextField(
                    paddingVer: 15,
                    controller: controllerCCCD,
                    typeInput: TypeInput.text,
                    labelText: 'Căn cước công dân',
                  ),
                  // CustomTextField(
                  //   paddingVer: 15,
                  //   controller: controllerBankName,
                  //   typeInput: TypeInput.text,
                  //   labelText: 'Mã số thuế',
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                    child: BaseButton(
                      width: double.infinity,
                      text: 'Cập nhật',
                      onTap: () {},
                    ),
                  )
                },
              ],
            ),
          ),
        ));
  }
}
