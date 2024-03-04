import 'package:dawaam_seller/const/const.dart';
import 'package:dawaam_seller/views/widgets/text_style.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: darkGrey,
          ),
        ),
        title: boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                autoPlay: true,
                height: 350,
                aspectRatio: 16 / 9,
                itemCount: data['p_imgs'].length,
                viewportFraction: 1.0,
                itemBuilder: (context, index) {
                  return Image.network(
                    data["p_imgs"][index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }),

            10.heightBox,

            //title and details section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(
                      text: "${data['p_name']}", color: fontGrey, size: 16.0),

                  10.heightBox,
                  Row(
                    children: [
                      boldText(
                          text: "${data['p_category']}",
                          color: fontGrey,
                          size: 16.0),
                      10.widthBox,
                      normalText(
                          text: "${data['p_subCategory']}",
                          color: fontGrey,
                          size: 16.0),
                    ],
                  ),
                  10.heightBox,
                  //rating
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                  ),

                  10.heightBox,
                  boldText(
                      text: "${data['p_price']}"
                          .numCurrencyWithLocale(locale: 'ur_PK')
                          .eliminateLast
                          .eliminateLast
                          .eliminateLast,
                      color: red,
                      size: 18.0),

                  20.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Color", color: fontGrey),
                          ),
                          Row(
                            children: List.generate(
                              data['p_colors'].length,
                              (index) => VxBox()
                                  .size(40, 40)
                                  .roundedFull
                                  .color(Color(data['p_colors'][index]))
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .make()
                                  .onTap(
                                () {
                                  // controller
                                  //     .changeColorIndex(index);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      20.heightBox,
                      //quantity row
                      Row(
                        children: [
                          SizedBox(
                              width: 100,
                              child:
                                  boldText(text: "Quantity", color: fontGrey)),
                          normalText(
                              text: "${data['p_quantity']} items",
                              color: fontGrey),
                        ],
                      ),
                    ],
                  ).box.white.padding(const EdgeInsets.all(8.0)).make(),

                  //description section
                  const Divider(),
                  20.heightBox,
                  boldText(text: "Description", color: fontGrey),

                  10.heightBox,
                  // "${data['p_desc']}".text.color(darkFontGrey).make(),
                  normalText(text: "${data['p_desc']} ", color: fontGrey),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
