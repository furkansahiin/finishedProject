import 'package:bidscape/consts/consts.dart';

Widget SearchWidget() {
  return Container(
    alignment: Alignment.center,
    height: containerheight60, // çünkü sonraki gelen widget alta gelsin

    child: TextFormField(
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.search),
        focusedBorder: InputBorder.none,
        focusColor: appcolor,
        hintText: searchHint,
        filled: true,
        fillColor: whiteColor,
        hintStyle: TextStyle(color: textfieldGrey),
        // prefixIcon: Icon(Icons.search), başa alır
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

// Widget titleNameAlign({String? title}) {
//   return Align(
//     alignment: Alignment.centerLeft,
//     child: title?.text.color(Colors.black).fontFamily(bold).size(size18).make(),
//   );
// }
