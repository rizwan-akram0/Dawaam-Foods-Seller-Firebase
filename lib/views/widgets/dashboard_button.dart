import 'package:dawaam_seller/const/const.dart';
import 'package:dawaam_seller/views/widgets/text_style.dart';

Widget dashboardButton(context, {title, count, icon}) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: "   $title", size: 22.0),
            Center(child: boldText(text: "$count", size: 32.0))
          ],
        ),
      ),
      Image.asset(
        icon,
        width: 50,
        color: white,
      ),
      20.widthBox,
    ],
  )
      .box
      .color(purpleColor)
      .rounded
      .size(size.width, 120)
      .padding(const EdgeInsets.all(8.0))
      .make();
}
