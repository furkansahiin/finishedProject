import 'package:bidscape/consts/consts.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  // changeScreen() {
  //   Future.delayed(Duration(seconds: 3), () {
  //     Get.to(() => DashboardFragments());
  //   });
  // }

  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  Future<void> checkLoginStatus() async {
    User? user = await RememberUserPrefs.readUserInfo();
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bgWidget(
        child: Center(
          child: Column(
            children: [
              Expanded(flex: 1, child: Container()),
              applogoWidget(),
              20.heightBox,
              appname.text.fontFamily(bold).size(22).white.make(),
              20.heightBox,
              appversiyon.text.white.make(),
              Spacer(),
              credits.text.white.fontFamily(semibold).make(),
              30.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
