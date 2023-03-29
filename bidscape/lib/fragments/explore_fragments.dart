import 'package:bidscape/consts/consts.dart';

class ExploreFragmentsScreen extends StatelessWidget {
  const ExploreFragmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Explore Fragments Screen",
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
