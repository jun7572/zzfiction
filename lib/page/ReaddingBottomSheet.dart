import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zzfiction/approute/AppRoutes.dart';
import 'package:zzfiction/approute/PageName.dart';
import 'package:zzfiction/controller/ReadController.dart';
import 'package:zzfiction/gen_a/A.dart';
import 'package:zzfiction/managers/screen_manager.dart';
import 'package:zzfiction/repository/FictionRepository.dart';
import 'package:zzfiction/utils/AppSettingUtil.dart';

import 'BrightnessBottomSheet.dart';

class ReaddingBottomSheet extends GetView<ReadController> {
  // double ii = 10;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReadController>(
      initState: (State state) {
        FictionRepository fictionRepository = Get.find<FictionRepository>();
        controller.title.value = fictionRepository.currentFictionSource.title;
        controller.percent.value =
            '${fictionRepository.currentFictionSource.readdingChapter}/${fictionRepository.currentFictionSource.chapters.length}';
      },
      init: Get.find<ReadController>(),
      builder: (ctr) {
        return Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(

                    onPressed: ctr.bottomSheetClick,
                    style: ElevatedButton.styleFrom(
                        primary: !ctr.mode ? Colors.white : Colors.blue,
                        shape: CircleBorder(),
                        padding: EdgeInsets.zero,
                        onSurface: Colors.blue),
                    child: !ctr.mode
                        ? Image.asset(A.assets_ri,width: getWp(44),height: getWp(44),fit:BoxFit.fill,)
                        : Image.asset(A.assets_ye,width: getWp(44),height: getWp(44),fit:BoxFit.fill),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),

              Container(
                color: Colors.black,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(() {
                            return Text(
                              ctr.title.value,
                              style: TextStyle(color: Colors.white),
                            );
                          }),
                        ),
                        Spacer(),
                        Obx(() {
                          return Text(
                            ctr.percent.value,
                            style: TextStyle(color: Colors.white),
                          );
                        }),
                        Spacer(),
                      ],
                    ),
                    Row(
                      children: [
                        bottomButton(
                            f: () async {
                              ctr.gk.currentState.openDrawer();
                              Get.back();
                            },
                            icon: Icons.list_rounded,
                            title: "目录"),
                        bottomButton(
                            f: () async {
                              ctr.refreshFiction();
                            },
                            icon: Icons.refresh_rounded,
                            title: "刷新"),

                        bottomButton(
                            f: () async {
                              Get.back();
                              Get.toNamed(AppPage.SetReaddingOptionPage)
                                  .then((v) async {
                                print("asdfasfasf");
                                await AppSettingUtil.initReaddingSetting();
                                ctr.reloadText();
                              });
                              //  await  AppSettingUtil.initReaddingSetting();
                              // ctr.reloadText();
                            },
                            icon: Icons.settings,
                            title: "设置"),
                        bottomButton(
                            f: () async {
                              Get.bottomSheet(BrightnessBottomSheet(),
                                  barrierColor: Colors.transparent);
                            },
                            icon: Icons.brightness_5,
                            title: "亮度"),
                      ],
                    ),
                  ],
                ),
              ),
              // Container(height: 10,,),
            ],
          ),
        );
      },
    );
  }
}

Widget bottomButton({Function f, IconData icon, String title}) {
  return Expanded(
      flex: 1,
      child: TextButton(
        onPressed: f,
        child: Column(
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ));
}
