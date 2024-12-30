import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_color.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool elevation;
  final String? title;
  final CustomAppBar? appBar;
  final List<Widget>? actions;
  final bool leading;
  final bool leadingIsBack;
  final String? iconData;
  final Function? actionPop;
  final bool centerTitle;
  final Widget? titleWidget;
  final bool? loading;
  final Color backgroudColor;

  const BaseAppBar(
      {super.key,
      this.elevation = false,
      this.title,
      this.appBar,
      this.actions,
      this.iconData,
      this.leading = true,
      this.leadingIsBack = true,
      this.actionPop,
      this.centerTitle = true,
      this.titleWidget,
      this.loading,
      this.backgroudColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      bottom: loading == true
          ? const PreferredSize(
              preferredSize: Size.fromHeight(1.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.white,
                minHeight: 1,
              ),
            )
          : null,
      elevation: elevation ? 1 : 0,
      bottomOpacity: 0.0,
      centerTitle: centerTitle,
      backgroundColor: backgroudColor,
      leading: leading
          ? Builder(
              builder: (BuildContext context) {
                return ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: IconButton(
                        iconSize: 22,
                        icon: Icon(
                          leadingIsBack ? Icons.arrow_back_ios : Icons.close,
                          color: AppColors.white,
                        ),
                        onPressed: () {
                          if (actionPop != null) {
                            actionPop!();
                          }
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                );
              },
            )
          : null,
      titleSpacing: leading ? 0 : 30,
      title: titleWidget ??
          (title == null
              ? Image.asset(
                  iconData!,
                  height: 40,
                  width: 160,
                )
              : iconData == null
                  ? Text(
                      title!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 18.sp),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(iconData!, width: 30, height: 30),
                          const SizedBox(width: 8),
                          Text(title!,
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.titleColor, fontSize: 24, fontWeight: FontWeight.w700))
                        ],
                      ),
                    )),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight((appBar ?? CustomAppBar()).preferredSize.height);
}

const IconThemeData iconThemeData = IconThemeData(opacity: 1.0, size: 18);

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key? key,
    Widget? leading,
    bool automaticallyImplyLeading = false,
    Widget? title,
    List<Widget>? actions,
    Widget? flexibleSpace,
    PreferredSizeWidget? bottom,
    double elevation = 0,
    Brightness brightness = Brightness.dark,
    IconThemeData iconTheme = iconThemeData,
    bool primary = true,
    bool centerTitle = true,
    double titleSpacing = NavigationToolbar.kMiddleSpacing,
    double toolbarOpacity = 1.0,
    double? toolbarHeight,
    double bottomOpacity = 1.0,
    double? leadingWidth,
    Color? backgroundColor,
  }) : super(
          key: key,
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: title,
          actions: actions,
          leadingWidth: leadingWidth,
          flexibleSpace: flexibleSpace,
          bottom: bottom,
          elevation: elevation,
          iconTheme: iconTheme,
          toolbarHeight: toolbarHeight,
          primary: primary,
          centerTitle: centerTitle,
          titleSpacing: titleSpacing = NavigationToolbar.kMiddleSpacing,
          toolbarOpacity: toolbarOpacity = 1.0,
          bottomOpacity: bottomOpacity = 1.0,
          backgroundColor: backgroundColor,
        );
}
