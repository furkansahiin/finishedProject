import 'package:bidscape/consts/consts.dart';


class HomeFragmentsScreen extends StatelessWidget {
  const HomeFragmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
          await Get.offAll(() => DashboardFragments());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                10.heightBox,
                SearchWidget(),
                10.heightBox,
                SliderWidget(),
                10.heightBox,
               
                TrendingListScreen(),
                20.heightBox,
                CategoryListScreen(),
                35.heightBox,
              ]
              ),
            ),
        ),
      ),
      
    );
  }
}
