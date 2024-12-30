library address_picker;

import 'dart:convert';

import 'package:cores_project/service/validator.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';

import '../model/local_address.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class AddressPicker extends StatefulWidget {
  final Widget Function(String? text)? buildItem;
  final Widget? underline;
  final EdgeInsets? insidePadding;
  final TextStyle? placeHolderTextStyle;
  final double paddingHoz;
  final double paddingVer;
  final Function(LocalAddress)? onAddressChanged;

  AddressPicker({this.buildItem, this.underline, this.insidePadding, this.placeHolderTextStyle, @required this.onAddressChanged, this.paddingHoz = 10, this.paddingVer = 10});

  @override
  _AddressPickerState createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
  List<Province> _provinceList = [];
  Province? _provinceSelected; // = Province(name_with_type: 'Chọn tỉnh/tp', districts: []);
  District? _districtSelected; // = District(name_with_type: 'Chọn quận/huyện', wards: []);
  Wards? _wardsSelected;

  _buildItem(String? text) {
    if (widget.buildItem != null) return widget.buildItem!(text);
    return Text(text ?? "");
  }

  @override
  void initState() {
    _loadViAddressDb().then((provinceList) {
      setState(() {
        _provinceList = provinceList;
      });
    });
    super.initState();
  }

  Future<List<Province>> _loadViAddressDb() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/vn_db.json");
    Map jsonResult = json.decode(data);

    List<Province> provinceList = [];
    Province? hanoi, hcm, cantho, danang;
    jsonResult.forEach((k, item) {
      Province provice = Province.fromJson(item);
      List<District> districtList = [];
      Map.castFrom(item['quan-huyen']).forEach((k2, item2) {
        District district = District.fromJson(item2);
        List<Wards> wardsList = [];
        Map.castFrom(item2['xa-phuong']).forEach((k3, item3) {
          Wards ward = Wards.fromJson(item3);
          wardsList.add(ward);
        });
        district.wards = wardsList;
        districtList.add(district);
      });
      provice.districts = districtList;
      if (provice.code == '01')
        hanoi = provice;
      else if (provice.code == '79')
        hcm = provice;
      else if (provice.code == '92')
        cantho = provice;
      else if (provice.code == '48')
        danang = provice;
      else
        provinceList.add(provice);
    });
    provinceList.sort((p1, p2) => p1.name!.compareTo(p2.name!));
    // Hanoi, HCM, Can Tho, Da Nang to Top
    if (hanoi != null) provinceList.insert(0, hanoi!);
    if (hcm != null) provinceList.insert(1, hcm!);
    if (cantho != null) provinceList.insert(2, cantho!);
    if (danang != null) provinceList.insert(3, danang!);
    return Future.value(provinceList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: widget.paddingHoz, vertical: widget.paddingVer),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: DropdownButtonFormField<Province>(
                isExpanded: true,
                decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
                validator: (value) => Validator.checkNull(value.toString(), messageErrorNull: 'Vui lòng chọn Tỉnh/Thành phố'),
                hint: Text('Chọn Tỉnh/ Thành phố *', style: TextStyle().merge(widget.placeHolderTextStyle != null ? widget.placeHolderTextStyle : null)),
                value: _provinceSelected,
                items: _provinceList.map((p) {
                  return DropdownMenuItem<Province>(
                    child: _buildItem(p.name),
                    value: p,
                  );
                }).toList(),
                onChanged: (p) {
                  setState(() {
                    _provinceSelected = p;
                    _districtSelected = null;
                    _wardsSelected = null;
                  });
                  widget.onAddressChanged!(LocalAddress(province: _provinceSelected?.name));
                }),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DropdownButtonFormField<District>(
                  hint: Text('Chọn Quận/ Huyện *', style: TextStyle().merge(widget.placeHolderTextStyle != null ? widget.placeHolderTextStyle : null)),
                  value: _districtSelected,
                  isExpanded: true,
                  decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
                  validator: (value) => Validator.checkNull(value.toString(), messageErrorNull: 'Vui lòng chọn Quận/Huyện'),
                  items: (_provinceSelected ?? Province(districts: [])).districts.map((d) {
                    return DropdownMenuItem<District>(
                      child: _buildItem(d.nameWithType),
                      value: d,
                    );
                  }).toList(),
                  onChanged: (d) {
                    setState(() {
                      _districtSelected = d;
                      _wardsSelected = null;
                    });
                    widget.onAddressChanged!(LocalAddress(province: _provinceSelected!.name, district: _districtSelected!.nameWithType));
                  })),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DropdownButtonFormField<Wards>(
                  hint: Text('Chọn Phường/ Xã *', style: TextStyle().merge(widget.placeHolderTextStyle != null ? widget.placeHolderTextStyle : null)),
                  value: _wardsSelected,
                  isExpanded: true,
                  decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
                  validator: (value) => Validator.checkNull(_wardsSelected.toString(), messageErrorNull: 'Vui lòng chọn Phường/xã'),
                  items: (_districtSelected ?? District(wards: [])).wards.map((w) {
                    return DropdownMenuItem<Wards>(
                      child: _buildItem(w.nameWithType),
                      value: w,
                    );
                  }).toList(),
                  onChanged: (w) {
                    setState(() {
                      _wardsSelected = w;
                    });
                    widget.onAddressChanged!(LocalAddress(province: _provinceSelected!.name, district: _districtSelected!.nameWithType, ward: _wardsSelected!.nameWithType));
                  }))
        ]));
  }
}
