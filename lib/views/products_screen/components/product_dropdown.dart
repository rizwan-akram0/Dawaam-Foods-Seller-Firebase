import 'package:dawaam_seller/const/const.dart';
import 'package:dawaam_seller/controllers/products_controller.dart';
import 'package:dawaam_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

Widget productDropdown(
    hint, List<String> list, dropvalue, ProductController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: "$hint", color: fontGrey),
        value: dropvalue.value == '' ? null : dropvalue.value,
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(
            value: e,
            child: e.toString().text.make(),
          );
        }).toList(),
        onChanged: (newvalue) {
          if (hint == "Category") {
            controller.subcategoryvalue.value = '';
            controller.populateSubcategory(newvalue.toString());
          }
          dropvalue.value = newvalue.toString();
        },
      ),
    )
        .box
        .white
        .roundedSM
        .padding(const EdgeInsets.symmetric(horizontal: 4))
        .make(),
  );
}
