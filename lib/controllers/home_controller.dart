import 'package:dawaam_seller/const/const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUsername();
    getOrderCount();
  }

  var navIndex = 0.obs;
  var username = '';
  var cc = '0';

  getUsername() async {
    var n = await firestore
        .collection(vendorCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['vendor_name'];
      }
    });
    username = n;
  }

  getOrderCount() async {
    var n = await firestore.collection(ordersCollection).get().then((value) {
      return value.docs.length;
    });
    return cc = n.toString();
  }
}
