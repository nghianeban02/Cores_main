import 'package:cores_project/bloc/account/account_cubit.dart';
import 'package:cores_project/bloc/activate/activate_cubit.dart';
import 'package:cores_project/screen/acvivate/info_product.dart';
import 'package:cores_project/screen/acvivate/select_image.dart';
import 'package:cores_project/storage/app_preferences.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'info_customer.dart';
import 'info_staff.dart';

class ActivateScreen extends StatefulWidget {
  const ActivateScreen({
    super.key,
  });

  @override
  State<ActivateScreen> createState() => _ActivateScreenState();
}

class _ActivateScreenState extends State<ActivateScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoaing = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(AppPreferencesImpl().getToken);
    BlocProvider.of<ActivateCubit>(context).resetform();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          floatingActionButton: BlocBuilder<ActivateCubit, ActivateState>(builder: (context, state) {
            if (state is AddActivateLoading) {
              isLoaing = state.isLoading;
            }
            return FloatingActionButton(
                backgroundColor: !isLoaing ? AppColors.primaryColor : AppColors.primaryColor.withOpacity(0.4),
                onPressed: () {
                  // Navigator.push(NavigateKeys().navigationKey.currentContext!, MaterialPageRoute(builder: (context) => ConfirmOtp()));
                  if (_formKey.currentState!.validate() && !isLoaing) {
                    BlocProvider.of<ActivateCubit>(context).addActivate();
                  }
                },
                child: const SizedBox(
                    width: 200,
                    child: Center(
                        child: Icon(
                      Icons.add,
                      color: AppColors.white,
                    ))));
          }),
          appBar: AppBar(
            title: const Text(
              'Đăng ký kích hoạt',
              style: TextStyle(color: AppColors.white),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              color: AppColors.greyLight.withOpacity(1),
              padding: const EdgeInsets.only(bottom: 60),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoProduct(),
                          SizedBox(
                            height: 20,
                          ),
                          InfoCustomer(),
                          SizedBox(
                            height: 10,
                          ),
                          if (BlocProvider.of<AccountCubit>(context).infoUserModel.idGroupUser!.contains('DOITAC')) InfoStaffActivate(),
                          SelectImage()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
