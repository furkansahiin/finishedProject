import 'dart:convert';
import 'package:bidscape/consts/consts.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var isObsecure = true.obs;
  var isObsecureconfirm = true.obs;
  bool? isCheck = false;

  final formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  validateUserEmail() async {
    try {
      var res = await http.post(Uri.parse(API.validateEmail),
        body: {
          "email": _emailController.text.trim(),
        }
      );

      if(res.statusCode == 200) {
        var resBodyOfValidateUserEmail = jsonDecode(res.body);

        if(resBodyOfValidateUserEmail["emailfound"] == true) {
          Get.snackbar(errorTitle, errorEmailAlreadyExist , snackPosition: SnackPosition.BOTTOM, backgroundColor: redColor, colorText: whiteColor,);
        } else {
          saveNewUser();
        }
      }

    } catch (e) {
      Get.snackbar(errorTitle, erorHostNotFound , snackPosition: SnackPosition.BOTTOM, backgroundColor: redColor, colorText: whiteColor,);
    }
  }
    Future<void> saveNewUser() async {
    User userModel = User(
      userId: 1,
      username: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      image: '',
      isAdmin: false,    
    );

    try {
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),
      );

      if (res.statusCode == 200) {
        var resBodyOfSaveNewUser = jsonDecode(res.body);

        if(resBodyOfSaveNewUser["status"] == true) {
         Get.snackbar(successTitle, errorSignupSuccess , snackPosition: SnackPosition.BOTTOM, backgroundColor: greenColor, colorText: whiteColor,);
          Get.offAll(() => LoginScreen());
        } else {
          Get.snackbar(errorTitle, errorSignupFail , snackPosition: SnackPosition.BOTTOM, backgroundColor: redColor, colorText: whiteColor,);
        }
      } else {
        Get.snackbar(errorTitle, res.statusCode.toString() , snackPosition: SnackPosition.BOTTOM, backgroundColor: redColor, colorText: whiteColor,);
      }
    } catch (e) {
      Get.snackbar(errorTitle, erorHostNotFound , snackPosition: SnackPosition.BOTTOM, backgroundColor: redColor, colorText: whiteColor,);
    }
  }
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Center(
                  child: Column(
                children: [
                  (context.screenHeight * 0.05).heightBox,
                  applogoWidget(),
                  10.heightBox,

                  20.heightBox,
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        custumTextFieldWidget(
                          hint: nameHint,
                          controller: _nameController,
                        ),
                        custumTextFieldWidget(
                          hint: emailHint,
                          controller: _emailController,
                        ),
                        Obx(
                          () => passwordtextfield(
                            hint: passwordHint,
                            isObsecure: isObsecure,
                            controller: _passwordController,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        Obx(
                          () => passwordtextfield(
                            hint: confirmPassHint,
                            isObsecure: isObsecureconfirm,
                            controller: _confirmpasswordController,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                                activeColor: appcolor,
                                checkColor: whiteColor,
                                value: isCheck,
                                onChanged: (newValue) {
                                  setState(() {
                                    isCheck = newValue;
                                  });
                                }),
                            Expanded(
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: termAndCond,
                                      style: TextStyle(
                                          color: appcolorred, fontFamily: regular)),
                                  TextSpan(
                                      text: and,
                                      style: TextStyle(
                                          color: darkfontGrey,
                                          fontFamily: regular)),
                                  TextSpan(
                                      text: privacyPolicyt,
                                      style: TextStyle(
                                          color: appcolorred, fontFamily: regular)),
                                  TextSpan(
                                      text: readAndAgree,
                                      style: TextStyle(
                                          color: darkfontGrey,
                                          fontFamily: regular)),
                                ]),
                              ),
                            ),
                          ],
                        ),
                        10.heightBox,
                        // signup button
                        ourButton(
                            color: isCheck == true ? appcolor : lightGrey,
                            title: signupButton,
                            textColor: whiteColor,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (_nameController.text.isEmpty ||
                                    _emailController.text.isEmpty ||
                                    _passwordController.text.isEmpty ||
                                    _confirmpasswordController.text.isEmpty) {
                                  Get.snackbar(errorTitle,textFieldEmpty , snackPosition: SnackPosition.BOTTOM, backgroundColor: redColor, colorText: whiteColor,);
                                } else if (isCheck == false) {
                                  Get.snackbar(
                                    errorTitle,
                                    errorAgreePrivacyandTerm,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: redColor,
                                    colorText: whiteColor,
                                  );
                                } else {
                                  if (_nameController.text.trim().length < 3) {
                                    Get.snackbar(
                                      errorTitle,
                                      nameError,
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: redColor,
                                      colorText: whiteColor,
                                    );
                                  } else if (_emailController.text.trim().length <
                                      3) {
                                    Get.snackbar(
                                      errorTitle,
                                      emailError,
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: redColor,
                                      colorText: whiteColor,
                                    );
                                  } else if (_passwordController.text
                                          .trim()
                                          .length <
                                      3) {
                                    Get.snackbar(
                                      errorTitle,
                                      passwordError,
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: redColor,
                                      colorText: whiteColor,
                                    );
                                  } else if (_passwordController.text !=
                                      _confirmpasswordController.text) {
                                    Get.snackbar(
                                      errorTitle,
                                      passwordNotMatch,
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: redColor,
                                      colorText: whiteColor,
                                    );
                                  } else {
                                    validateUserEmail();
                                  }
                                }
                              } else {
                                Get.snackbar(errorTitle, errorFormNotValid,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: redColor,
                                    colorText: whiteColor);
                              }
                            }).box.width(context.screenWidth - 50).make(),
                        10.heightBox,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: haveAAccount,
                                  style: TextStyle(
                                      color: darkfontGrey, fontFamily: regular)),
                              TextSpan(
                                  text: loginButton,
                                  style: TextStyle(
                                      color: appcolorred, fontFamily: regular)),
                            ],
                          ),
                        ).onTap(() {
                          Get.back();
                        }),
                      ],
                    )
                        .box
                        .white
                        .rounded
                        .padding(EdgeInsets.all(16.0))
                        .margin(EdgeInsets.all(16.0))
                        .width(context.screenWidth - 60)
                        .make(),
                  ),
                ],
              )),
            )),
      ),
    );
  }
}
