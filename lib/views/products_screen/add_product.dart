import 'package:dawaam_seller/const/const.dart';
import 'package:dawaam_seller/controllers/products_controller.dart';
import 'package:dawaam_seller/views/products_screen/components/product_dropdown.dart';
import 'package:dawaam_seller/views/products_screen/components/product_images.dart';
import 'package:dawaam_seller/views/products_screen/products_screen.dart';
import 'package:dawaam_seller/views/widgets/custom_textfield.dart';
import 'package:dawaam_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: boldText(text: "Add Product", size: 16.0),
          actions: [
            controller.isloading.value
                ? const Center(
                    child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(white),
                  ))
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.uploadImages();
                      await controller.uploadProduct(context);
                      controller.pnameController.clear();
                      controller.pdescController.clear();
                      controller.ppriceController.clear();
                      controller.pquantityController.clear();
                      controller.categoryList.clear();
                      controller.subcategoryList.clear();
                      controller.pImagesList.clear;
                      controller.pImagesList =
                          RxList<dynamic>.generate(3, (index) => null);

                      Get.back();
                      controller.pImagesLinks.clear();
                    },
                    child: boldText(text: "Save"))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    hint: "Name",
                    label: "Product name",
                    controller: controller.pnameController),
                10.heightBox,
                customTextField(
                    hint: "Nice product",
                    label: "Description",
                    isDesc: true,
                    controller: controller.pdescController),
                10.heightBox,
                customTextField(
                    hint: "1000",
                    label: "Price",
                    controller: controller.ppriceController),
                10.heightBox,
                customTextField(
                    hint: "20",
                    label: "Quantity",
                    controller: controller.pquantityController),
                10.heightBox,
                productDropdown("Category", controller.categoryList,
                    controller.categoryvalue, controller),
                10.heightBox,
                productDropdown("Subcategory", controller.subcategoryList,
                    controller.subcategoryvalue, controller),
                10.heightBox,
                const Divider(
                  color: white,
                ),
                boldText(text: "Choose product images"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => controller.pImagesList[index] != null
                          ? Image.file(
                              controller.pImagesList[index],
                              width: 100,
                            ).onTap(() {
                              controller.pickImage(index, context);
                            })
                          : productImages(label: "${index + 1}").onTap(() {
                              controller.pickImage(index, context);
                            }),
                    ),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "First image will be your display image",
                    color: lightGrey),
                const Divider(
                  color: white,
                ),
                10.heightBox,
                Row(
                  children: [
                    boldText(text: "This product has different sizes: "),
                    Obx(
                      () => Checkbox(
                          side: const BorderSide(width: 2, color: white),
                          value: controller.isChecked.value,
                          onChanged: (bool? value) {
                            controller.isChecked.value = value!;
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
