import 'package:bidscape/consts/consts.dart';

class FavoriteFragmentsScreen extends StatelessWidget {
  const FavoriteFragmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Favoriler",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),              

      ),
    );
  }
}
