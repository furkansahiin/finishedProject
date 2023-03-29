import 'dart:convert';
import 'package:bidscape/consts/consts.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var isObsecure = true.obs;

  bool _isLoading = false;

  Future<void> loginUserNow() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await http.post(
        Uri.parse(API.login),
        body: {
          "email": emailController.text,
          "password": passwordController.text,
        },
      );
      setState(() {
        _isLoading = false;
      });
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        if(data['success'] == true){
          User user = User.fromJson(data['userData']);
          RememberUserPrefs.storeUserInfo(user);
         Get.snackbar(successTitle, errorLoginSuccess , snackPosition: SnackPosition.BOTTOM, backgroundColor: greenColor, colorText: whiteColor,);
          Get.offAll(() => DashboardFragments());
        }else{
          Get.snackbar(errorTitle, response.statusCode.toString() , snackPosition: SnackPosition.BOTTOM, backgroundColor: redColor, colorText: whiteColor,);
        }
     }
    } catch (errorMsg) {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar(errorTitle, errorMsg.toString(), snackPosition: SnackPosition.BOTTOM, backgroundColor: redColor, colorText: whiteColor,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
                child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                appNoTextlogoWidget(),
                10.heightBox,
                appname.text.fontFamily(bold).size(22).white.make(),
                20.heightBox,
                Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          custumTextFieldWidget(
                            controller: emailController,
                            hint: emailHint,
                          ),
                          Obx(
                            () => passwordtextfield(
                              controller: passwordController,
                              hint: passwordHint,
                              isObsecure: isObsecure,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: forgetPass.text.black.make())),
                    5.heightBox,
                    // login button
                    _isLoading
                      ? CircularProgressIndicator()
                      : ourButton(
                            title: loginButton,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                loginUserNow();
                              } else {
                                Get.snackbar(errorTitle, textFieldEmpty, snackPosition: SnackPosition.BOTTOM, backgroundColor: redColor, colorText: whiteColor,);
                              }
                            },
                            textColor: blackColor,
                            color: appcolor)
                        .box
                        .width(context.screenWidth - 50)
                        .make(),
                    10.heightBox,
                    createNewAccount.text.black.make(),
                    10.heightBox,
                    ourButton(
                            title: signupButton,
                            onPressed: () {
                              Get.to(() => const SignupScreen());
                            },
                            textColor: blackColor,
                            color: appcolor)
                        .box
                        .width(context.screenWidth - 50)
                        .make(),
                    5.heightBox,
                    
                  ],
                )
                    .box
                    .white
                    .rounded
                    .padding(const EdgeInsets.all(16.0))
                    .width(context.screenWidth - 60)
                    .make(),
              ],
            ))),
      ),
    );
  }
}
