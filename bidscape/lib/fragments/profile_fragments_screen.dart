import 'package:bidscape/consts/consts.dart';

class ProfileFragmentsScreen extends StatelessWidget {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  signOutUser() async {
    var _result = await Get.dialog(
      AlertDialog(
        title: Text("Emin misiniz?"),
        content: Text("Çıkış yapmak istediğinize emin misiniz?"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );

    if (_result == true) {
      RememberUserPrefs.removeUserInfo().then((value) {
        Get.off(LoginScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: bgWidget(
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: padding8all,
                child: Column(
                  children: [
                    // edit profile button
                    // profile image
                    Column(
                      children: [
                        Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              icNoTextLogo,
                              // _rememberCurrentUser.user.value.profileImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // profile name
                      16.heightBox,
                      _rememberCurrentUser.user.username.text.xl2.make(),
                      8.heightBox,
                      // profile email
                      _rememberCurrentUser.user.email.text.make(),
            
                      ]
                    ),
                    // buttons section
                    40.heightBox,
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Icon(
                            profileButtonsIcon[index],
                            color: appcolor,
                          ),
                          title: profileButtons[index].text.make(),
                          onTap: () {
                            if (index == 0) {
                              Get.to(() => ProfileEditScreen());
                            } else if (index == 4) {
                              signOutUser();
                            }
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(color: appcolor,);
                      },
                      itemCount: profileButtons.length,
                    )
                        .box
                        // .white
                        .rounded
                        .padding(EdgeInsets.symmetric(horizontal: 16))
                        .make(),

                    // develapper info
                    20.heightBox,
                    appname.text.fontFamily(bold).size(22).color(appcolorred).make(),
                    10.heightBox,
                    appversiyoncredits.text.color(appcolorred).make(),
                    20.heightBox,
                  
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
