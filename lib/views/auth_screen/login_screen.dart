import 'package:dawaam_seller/const/const.dart';
import 'package:dawaam_seller/controllers/auth_controller.dart';
import 'package:dawaam_seller/views/widgets/our_button.dart';
import 'package:dawaam_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

import '../home_screen/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              30.heightBox,
              normalText(
                text: welcome,
                size: 18.0,
              ),
              20.heightBox,
              Row(
                children: [
                  Image.asset(
                    iclogo,
                    width: 80,
                    height: 80,
                  )
                      .box
                      .border(color: white)
                      .rounded
                      .padding(const EdgeInsets.all(8))
                      .make(),
                  10.widthBox,
                  boldText(text: appname, size: 20.0),
                ],
              ),
              70.heightBox,
              Obx(
                () => Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                        prefixIcon: Icon(
                          Icons.email,
                          color: purpleColor,
                        ),
                        hintText: emailHint,
                        border: InputBorder.none,
                      ),
                    ),
                    10.heightBox,
                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: purpleColor,
                        ),
                        hintText: passwordHint,
                        border: InputBorder.none,
                      ),
                    ),
                    10.heightBox,
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: normalText(
                              text: forgotPassword, color: purpleColor)),
                    ),
                    10.heightBox,
                    SizedBox(
                      width: context.screenWidth - 100,
                      child: controller.isloading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(purpleColor),
                            )
                          : ourButton(
                              title: login,
                              onPress: () async {
                                controller.isloading(true);
                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: loggedin);
                                    controller.isloading(false);
                                    Get.offAll(() => const Home());
                                  } else {
                                    controller.isloading(false);
                                  }
                                });
                              },
                            ),
                    ),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .outerShadowMd
                    .padding(const EdgeInsets.all(8.0))
                    .make(),
              ),
              10.heightBox,
              Center(child: normalText(text: anyProblem, color: lightGrey)),
              const Spacer(),
              Center(child: normalText(text: credit)),
              10.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
