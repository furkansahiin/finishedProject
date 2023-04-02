import 'package:bidscape/consts/consts.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Profile Edit"),
      ),
      body: Center(child: "Profile Edit".text.make()),
    ));
  }
}
