import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:carousel_slider_plus/carousel_options.dart';
import 'package:cores_project/bloc/account/account_cubit.dart';
import 'package:cores_project/model/info_user_model.dart';
import 'package:cores_project/screen/widget/menu_home.dart';
import 'package:cores_project/service/launch_url.dart';
import 'package:cores_project/utils/app_assets.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:cores_project/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'news/news_screen.dart';
import 'widget/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final List<String> imgList = [AppAssets.slide1, AppAssets.slide2, AppAssets.slide3, AppAssets.slide4, AppAssets.slide5];

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> imageSliders = imgList
      .map(
        (item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                ],
              )),
        ),
      )
      .toList();
  late AccountCubit accountCubit;
  InfoUserModel infoUserModel = InfoUserModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accountCubit = BlocProvider.of<AccountCubit>(context)..getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // print(AppPreferencesImpl().getToken.toString());
            CustomURL().launchCaller('18000079');
          },
          backgroundColor: AppColors.primaryColor,
          icon: const Icon(Icons.phone_in_talk),
          label: const Text("1800 0079"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        key: _scaffoldKey,
        drawer: const CustomDrawer(),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NewsScreen()));
                },
                icon: const Icon(
                  Icons.notifications,
                  color: AppColors.primaryColor,
                ))
          ],
          centerTitle: true,
          title: CustomText().textSize24(
            title: 'Trang chủ',
            fontWeight: FontWeight.w700,
            color: AppColors.primaryColor,
          ),
          leading: IconButton(
            onPressed: () {
              _openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          bottomOpacity: 0,
          elevation: 0.0,
          backgroundColor: AppColors.greyLight,
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: <Color>[AppColors.greyLight, Color.fromARGB(255, 230, 230, 230)]),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: imageSliders,
                ),
                Expanded(child: BlocBuilder<AccountCubit, AccountState>(
                  builder: (context, state) {
                    if (state is GetUserSuccess) {
                      infoUserModel = state.infoUserModel;
                    }
                    return infoUserModel.idGroupUser != null
                        ? MenuHome(
                            isDOITAC: infoUserModel.idGroupUser!.contains('DOITAC'),
                          )
                        : const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                  },
                ))
              ],
            )));
  }

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }
}
