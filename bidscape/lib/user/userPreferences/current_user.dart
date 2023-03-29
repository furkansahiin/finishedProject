import 'package:bidscape/consts/consts.dart';


class CurrentUser extends GetxController {
  Rx<User> _currentUser = User(
    userId: 0,
    username: '',
    email: '',
    password: '',
    image: '',
    isAdmin: false,
  ).obs;

  User get user => _currentUser.value;

  getUserInfo() async {
    User? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInfoFromLocalStorage!;
  }
}
