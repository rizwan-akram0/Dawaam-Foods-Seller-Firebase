import 'package:dawaam_seller/const/const.dart';
import 'package:dawaam_seller/views/widgets/text_style.dart';

Widget ourButton({title, color = purpleColor, onPress}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: color,
      padding: const EdgeInsets.all(12.0),
    ),
    onPressed: onPress,
    child: boldText(
      text: title,
      size: 16.0,
    ),
  );
}
