import 'package:bidscape/consts/consts.dart';

class ExploreFragmentsScreen extends StatelessWidget {
  const ExploreFragmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  title: Text('Keşfet'),
                  centerTitle: true,
                  backgroundColor: appcolorred,
                ),
                20.heightBox,
                const ExploreListScreen(),
                20.heightBox,
              ],
            ),
          ),
        ),
      
    );
  }
}
