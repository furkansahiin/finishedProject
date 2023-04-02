import 'package:bidscape/consts/consts.dart';

class ProductDetail extends StatelessWidget {
  final String title;
  final String properties;
  final String image;

  const ProductDetail({
    Key? key,
    required this.title,
    required this.properties,
    required this.image,
  }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              image,
              fit: BoxFit.fitWidth,
              height: 300,
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                properties,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
