import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawaam_seller/const/const.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  var orders = [];

  var confirmed = false.obs;
  var ondelivery = false.obs;
  var delivered = false.obs;

  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == currentUser!.uid) {
        orders.add(item);
      }
    }
  }

  changeStatus({context, title, status, docId}) async {
    var store = firestore.collection(ordersCollection).doc(docId);

    await store.set({title: status}, SetOptions(merge: true));
    VxToast.show(context, msg: "msg");
  }
}
