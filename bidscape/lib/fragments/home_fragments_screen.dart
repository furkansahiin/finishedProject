import 'package:bidscape/consts/consts.dart';

class HomeFragmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Home Fragments Screen",
            style: TextStyle(
              color: appcolor,
              fontSize: size18,
              fontFamily: bold,
            ),
          ),
        ),
      ),
    );
  }
}
