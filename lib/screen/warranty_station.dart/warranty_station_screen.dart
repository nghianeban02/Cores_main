import 'package:cores_project/bloc/warranty_station/warranty_station_cubit.dart';
import 'package:cores_project/model/address_model.dart';
import 'package:cores_project/model/station_model.dart';
import 'package:cores_project/service/launch_url.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:nb_utils/nb_utils.dart';

class WarrantyStation extends StatefulWidget {
  const WarrantyStation({super.key});

  @override
  State<WarrantyStation> createState() => _WarrantyStationState();
}

class _WarrantyStationState extends State<WarrantyStation> {
  late WarrantyStationCubit warrantyStationCubit;
  final textConntroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    warrantyStationCubit = BlocProvider.of<WarrantyStationCubit>(context)
      ..getListCity()
      ..getListStation();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Trạm bảo hành'),
          ),
          body: Column(
            children: [
              TypeAheadField(
                suggestionsBoxDecoration: SuggestionsBoxDecoration(),
                textFieldConfiguration: TextFieldConfiguration(
                    controller: textConntroller,
                    //autofocus: true,
                    // style: DefaultTextStyle.of(context).style.copyWith(fontStyle: FontStyle.italic),
                decoration: InputDecoration(hintText: 'Tìm kiếm', border: OutlineInputBorder())),
                suggestionsCallback: (pattern) async {
                  return await warrantyStationCubit.getListCity(search: pattern);
                },
                itemBuilder: (context, suggestion) {
                  return CustomText().textSize18(title: (suggestion as ListDataAddress).name).paddingSymmetric(horizontal: 10, vertical: 10);
                },
                onSuggestionSelected: (suggestion) async {
                  print((suggestion as ListDataAddress).name);
                  textConntroller.text = suggestion.name ?? '';
                  await warrantyStationCubit.getListStation(id: (suggestion.id ?? 0).toString());
                },
              ).paddingAll(16),
              
              Expanded(
                child: BlocBuilder<WarrantyStationCubit, WarrantyStationState>(
                  buildWhen: (previous, current) => current is StationSuccess,
                  builder: (context, state) {
                    return warrantyStationCubit.listStation.isNotEmpty
                        ? ListView.builder(
                            itemCount: warrantyStationCubit.listStation.length,
                            itemBuilder: (context, index) {
                              return itemlist(warrantyStationCubit.listStation[index]);
                            })
                        : Loader();
                  },
                ),
              )
            ],
          ),
        ));
  }

  itemlist(StationModel stationModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: AppColors.greyLight.withOpacity(0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [CustomText().textSize18(title: stationModel.name), callPhone(stationModel.phone ?? ''), address(stationModel)],
      ),
    ).paddingTop(6);
  }

  callPhone(String text) {
    List listPhone = text.contains('/') ? text.split('/') : text.split(',');
    print(listPhone);
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.phone,
              size: 15,
              color: AppColors.grey,
            ),
            for (int i = 0; i < listPhone.length; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText().textSize14(text: listPhone[i]).withWidth(120).onTap(() {
                    CustomURL().launchCaller(listPhone[i]);
                  })
                ],
              ),
          ],
        ).paddingSymmetric(vertical: 5).paddingRight(10));
  }

  address(StationModel stationModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.location_city,
          size: 15,
          color: AppColors.grey,
        ),
        Expanded(child: CustomText().textSize14(text: stationModel.addressFull)),
      ],
    ).paddingSymmetric(vertical: 5).onTap(() {
      MapsLauncher.launchQuery(stationModel.addressFull ?? '');
    });
  }
}
