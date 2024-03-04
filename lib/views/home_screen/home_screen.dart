import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawaam_seller/const/const.dart';
import 'package:dawaam_seller/controllers/home_controller.dart';
import 'package:dawaam_seller/services/store_services.dart';
import 'package:dawaam_seller/views/products_screen/product_details.dart';
import 'package:dawaam_seller/views/widgets/appbar_widget.dart';
import 'package:dawaam_seller/views/widgets/dashboard_button.dart';
import 'package:dawaam_seller/views/widgets/text_style.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Scaffold(
        appBar: appbarWidget(dashboard),
        body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(purpleColor),
              ));
            } else {
              var data = snapshot.data!.docs;
              data = data.sortedBy(
                (a, b) =>
                    b['p_whishlist'].length.compareTo(a['p_whishlist'].length),
              );
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context,
                            title: products,
                            count: "${data.length}",
                            icon: icProducts),
                        10.heightBox,
                        dashboardButton(context,
                            title: orders,
                            count: controller.cc,
                            icon: icOrders),
                      ],
                    ),
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    boldText(text: popular, color: fontGrey, size: 16.0),
                    20.heightBox,
                    ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        data.length,
                        (index) => data[index]['p_whishlist'].length == 0
                            ? const SizedBox()
                            : ListTile(
                                onTap: () {
                                  Get.to(
                                      () => ProductDetails(data: data[index]));
                                },
                                leading: Image.network(
                                  data[index]['p_imgs'][0],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                title: boldText(
                                    text: "${data[index]['p_name']}",
                                    color: fontGrey,
                                    size: 14.0),
                                subtitle: normalText(
                                    text: "${data[index]['p_price']}",
                                    color: darkGrey),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
