import 'dart:convert';
import 'dart:io';

import 'package:cores_project/bloc/activate/activate_cubit.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:cores_project/utils/utils.dart';
import 'package:cores_project/widget/custom_button.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({super.key});

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  XFile? image;

  // Capture a video
  late ActivateCubit acitvateCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    acitvateCubit = BlocProvider.of<ActivateCubit>(context);
  }

  final _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUploadImage('Hình ảnh', 'Chụp hoặc / chọn ảnh ', image, takeModelSerial),
      ],
    );
  }

  _buildUploadImage(String title, String text, XFile? fileImage, final voidCallback) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            CustomText().textSize20(title: title, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
            // CustomText(
            //   text: ' *',
            //   color: AppColors.error,
            // )
          ],
        ),
        CustomText().textSize12(text: text).paddingSymmetric(vertical: 10),
        InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: (() {
              showModalBottomSheet(backgroundColor: Colors.white.withOpacity(0), context: context, builder: ((context) => bottomSheet(voidCallback)));
            }),
            child: Container(
              height: fileImage == null ? 145.h : 200.h,
              decoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Center(
                child: fileImage != null
                    ? Image(
                        image: FileImage(
                          File(fileImage.path),
                        ),
                        fit: BoxFit.fitWidth,
                      )
                    : Icon(
                        Icons.camera_alt,
                        color: AppColors.grey,
                        size: 30,
                      ),
              ),
            ))
      ],
    );
  }

  Widget bottomSheet(final voidCallback) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              color: AppColors.greyLight,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Chọn từ',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey, fontWeight: FontWeight.w700, height: 1.5),
                  ),
                ),
                const Divider(height: 1, thickness: 0.5, color: AppColors.grey),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: (() {
                        Utils.checkPermission(context);
                        // isFont ? takePhotoFont(ImageSource.camera) : takePhotoBack(ImageSource.camera);
                        voidCallback(ImageSource.camera);
                      }),
                      icon: const Icon(Icons.camera_alt_rounded),
                      style: const ButtonStyle(),
                      label: Text(
                        'Máy ảnh',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Divider(height: 1, thickness: 0.5, color: AppColors.grey),
                    TextButton.icon(
                      onPressed: (() {
                        Utils.checkPermission(context);
                        voidCallback(ImageSource.gallery);
                      }),
                      icon: const Icon(Icons.image),
                      label: Text(
                        'Thư viện',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: BaseButton(
              width: double.infinity,
              text: 'Hủy',
              onTap: () => Navigator.pop(context),
              textColor: AppColors.white,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void takeModelSerial(ImageSource imageSource) async {
    final pickFile = await _picker.pickImage(source: imageSource, imageQuality: 25);
    if (pickFile != null) {
      image = pickFile;

      acitvateCubit.selectImage = image;
    }

    setState(() {
      acitvateCubit.uploadImage();
    });
    Navigator.of(context).pop();
  }

  String convertToBase64(XFile file) {
    final imageBytes = File(file.path).readAsBytesSync();

    String base64Image = base64Encode(imageBytes);
    print(base64Image);
    return base64Image;
  }
}
