import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawaam_seller/const/const.dart';
import 'package:dawaam_seller/controllers/orders_controller.dart';
import 'package:dawaam_seller/services/store_services.dart';
import 'package:dawaam_seller/views/order_screen/order_details.dart';
import 'package:dawaam_seller/views/widgets/appbar_widget.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../widgets/text_style.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
      appBar: appbarWidget(orders),
      body: StreamBuilder(
        stream: StoreServices.getOrders(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(purpleColor),
            ));
          } else {
            var data = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length,
                    (index) {
                      var time = data[index]['order_date'].toDate();
                      return ListTile(
                        onTap: () {
                          Get.to(() => OrderDetails(
                                data: data[index],
                              ));
                        },
                        tileColor: textfieldGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: boldText(
                            text: "${data[index]['order_code']}",
                            color: purpleColor,
                            size: 14.0),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: fontGrey,
                                ),
                                10.widthBox,
                                boldText(
                                    text: intl.DateFormat()
                                        .add_yMd()
                                        .format(time),
                                    color: fontGrey),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.payment,
                                  color: fontGrey,
                                ),
                                10.widthBox,
                                boldText(text: unpaid, color: red),
                              ],
                            ),
                          ],
                        ),
                        trailing: boldText(
                            text: "${data[index]['total_amount']}"
                                .numCurrencyWithLocale(locale: "ur_PK")
                                .eliminateLast
                                .eliminateLast
                                .eliminateLast,
                            color: purpleColor,
                            size: 16.0),
                      ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                    },
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
