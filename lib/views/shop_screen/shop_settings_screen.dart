import 'package:dawaam_seller/const/const.dart';
import 'package:dawaam_seller/controllers/profile_controller.dart';
import 'package:dawaam_seller/views/widgets/custom_textfield.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopSettings, size: 16.0),
          actions: [
            controller.isloading.value
                ? const Center(
                    child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(white),
                  ))
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.updateShop(
                        shopaddress: controller.shopAddressController.text,
                        shopdesc: controller.shopDescController.text,
                        shopwebsite: controller.shopWebsiteController.text,
                        shopmobile: controller.shopMobileController.text,
                        shopname: controller.shopNameController.text,
                      );
                      VxToast.show(context, msg: "Shop Updated");
                    },
                    child: normalText(text: save)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                controller: controller.shopNameController,
                label: shopName,
                hint: nameHint,
              ),
              10.heightBox,
              customTextField(
                controller: controller.shopAddressController,
                label: address,
                hint: shopAddressHint,
              ),
              10.heightBox,
              customTextField(
                controller: controller.shopMobileController,
                label: mobile,
                hint: shopMobileHint,
              ),
              10.heightBox,
              customTextField(
                controller: controller.shopWebsiteController,
                label: website,
                hint: showWebsiteHint,
              ),
              10.heightBox,
              customTextField(
                controller: controller.shopDescController,
                label: description,
                hint: shopDescHint,
                isDesc: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
