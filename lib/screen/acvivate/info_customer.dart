import 'package:cores_project/bloc/address/address_cubit.dart';
import 'package:cores_project/model/address_model.dart';
import 'package:cores_project/model/customer_model.dart';
import 'package:cores_project/service/validator.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/activate/activate_cubit.dart';
import '../../widget/custom_text.dart';
import '../../widget/dropdown_address.dart';

class InfoCustomer extends StatefulWidget {
  final bool isCustomer;
  const InfoCustomer({super.key, this.isCustomer = false});

  @override
  State<InfoCustomer> createState() => _InfoCustomerState();
}

class _InfoCustomerState extends State<InfoCustomer> {
  final controllerName = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerStreet = TextEditingController();
  final controllerCity = TextEditingController();
  final controllerDistrist = TextEditingController();
  final controllerWard = TextEditingController();

  List<ListDataAddress> listCity = [];
  List<ListDataAddress> listDistrist = [];
  List<ListDataAddress> listWard = [];
  late ActivateCubit activateCubit;
  // final controllerNameProduct = TextEditingController();
  // final controllerDateActivate = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddressCubit>(context).getListCity();
    activateCubit = BlocProvider.of<ActivateCubit>(context)..getListCategory();
    activateCubit.customer = Customer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomText().textSize20(title: 'Thông tin khách hàng', color: AppColors.primaryColor, fontWeight: FontWeight.w600),
      const SizedBox(
        height: 10,
      ),
      CustomTextField(
        onChanged: (value) {
          activateCubit.updateFormCustomer(fullName: value);
        },
        paddingHoz: 10,
        controller: controllerName,
        typeInput: TypeInput.text,
        validator: (value) => Validator.checkNull(value, messageErrorNull: 'Vui lòng nhập họ tên'),
        labelText: 'Họ tên *',
      ),
      CustomTextField(
        onChanged: (value) {
          activateCubit.updateFormCustomer(phone: value);
        },
        paddingVer: 10,
        paddingHoz: 10,
        controller: controllerPhone,
        validator: (value) => Validator.checkPhoneNumber(value),
        typeInput: TypeInput.phone,
        labelText: 'Số điện thoại *',
      ),
      DropdownAddress(
        type: 'tinh',
        controller: controllerCity,
        controllerDistrist: controllerDistrist,
        controllerWard: controllerWard,
        labelText: 'Tỉnh/Thành phố *',
      ),
      DropdownAddress(
        type: 'quan',
        labelText: 'Quận/Huyện *',
        controller: controllerDistrist,
        controllerWard: controllerWard,
      ),
      DropdownAddress(
        type: 'ward',
        controller: controllerWard,
        labelText: 'Phường/Xã *',
      ),
      CustomTextField(
        paddingVer: 10,
        paddingHoz: 10,
        controller: controllerStreet,
        validator: (value) => Validator.checkNull(value, messageErrorNull: 'Vui lòng nhập địa chỉ'),
        typeInput: TypeInput.text,
        onChanged: (value) {
          activateCubit.updateFormCustomer(street: value);
        },
        labelText: 'Số nhà,đường *',
      ),
    ]);
  }
}
