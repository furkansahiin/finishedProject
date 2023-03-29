import 'package:bidscape/consts/consts.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        // fontFamily: regular,
      ),
      getPages: [
        GetPage(name: '/', page: () => const MyApp()),
        GetPage(name: '/home', page: () => DashboardFragments()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/singup', page: () => const SignupScreen()),
        GetPage(name: '/editprofile', page: () => const ProfileEditScreen()),
        // GetPage(name: '/ayarlar', page: () => const SettingsScreen()),
        // GetPage(name: '/search', page: () => const SearchFragments()),
        // GetPage(name: '/profile', page: () => const ProfileFragments()),
        // GetPage(name: '/notification', page: () => const NotificationFragments()),
        // GetPage(name: '/favorite', page: () => const FavoriteFragments()),
      ],
      home: FutureBuilder(
      future: RememberUserPrefs.readUserInfo(),
      builder: (context, dataSnapShot) {
        if (dataSnapShot.data == null) {
          return splashScreen(); 
        } else {
          return DashboardFragments();
        }
      },
    ),
    );
  }
}
