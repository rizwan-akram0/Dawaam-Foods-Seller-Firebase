import 'dart:io';

import 'package:dawaam_seller/const/const.dart';
import 'package:dawaam_seller/controllers/profile_controller.dart';
import 'package:dawaam_seller/views/widgets/custom_textfield.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../widgets/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editProfile, size: 16.0),
          actions: [
            controller.isloading.value
                ? const Center(
                    child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(white),
                  ))
                : TextButton(
                    onPressed: () async {
                      //if image is not selected
                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImgLink =
                            controller.snapshotData['imageUrl'];
                      }
                      //if old password matches database
                      if (controller.snapshotData['password'] ==
                          controller.oldpassController.text) {
                        await controller.changeAuthPassword(
                          email: controller.snapshotData['email'],
                          password: controller.oldpassController.text,
                          newpassword: controller.newpassController.text,
                        );
                        await controller.updateProfile(
                          imgUrl: controller.profileImgLink,
                          name: controller.nameController.text,
                          password: controller.newpassController.text,
                        );
                        VxToast.show(context, msg: "Updated");
                      } else if (controller
                              .oldpassController.text.isEmptyOrNull &&
                          controller.newpassController.text.isEmptyOrNull) {
                        await controller.updateProfile(
                          imgUrl: controller.profileImgLink,
                          name: controller.nameController.text,
                          password: controller.snapshotData['password'],
                        );
                      } else {
                        VxToast.show(context, msg: "Wrong Old Password");
                        controller.isloading(false);
                      }
                    },
                    child: normalText(text: save)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //if data image url and controller path is empty
              controller.snapshotData['imageUrl'] == '' &&
                      controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProduct,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  //if data image is not empty but controller path is empty
                  : controller.snapshotData['imageUrl'] != '' &&
                          controller.profileImgPath.isEmpty
                      ? Image.network(
                          controller.snapshotData['imageUrl'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      //else
                      : Image.file(
                          File(controller.profileImgPath.value),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),

              10.heightBox,
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: white),
                onPressed: () {
                  controller.changeImage(context);
                },
                child: normalText(text: changeImage, color: fontGrey),
              ),
              10.heightBox,
              const Divider(color: white),
              customTextField(
                  label: name,
                  hint: "Dawaam",
                  controller: controller.nameController),
              20.heightBox,
              boldText(text: "Change your password"),
              20.heightBox,
              customTextField(
                  isPass: true,
                  label: password,
                  hint: passwordHint,
                  controller: controller.oldpassController),
              10.heightBox,
              customTextField(
                  isPass: true,
                  label: confirmPass,
                  hint: passwordHint,
                  controller: controller.newpassController),
            ],
          ),
        ),
      ),
    );
  }
}
