import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dawaam_seller/const/const.dart';
import 'package:dawaam_seller/views/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

Widget chatBubble(DocumentSnapshot data, context) {
  var size = MediaQuery.of(context).size;
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();

  var time = intl.DateFormat("h:mma").format(t);

  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.ltr : TextDirection.ltr,
    child: Container(
      constraints: BoxConstraints(maxWidth: size.width * 0.65),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: data['uid'] == currentUser!.uid ? purpleColor : darkGrey,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['msg']}".text.white.size(16).make(),
          10.heightBox,
          time.text.color(white.withOpacity(0.5)).size(6).make(),
        ],
      ),
    ),
  );
}
