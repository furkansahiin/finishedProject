import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bidscape/consts/consts.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> _images = [];

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    final response = await http.get(Uri.parse('http://localhost/images_api.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _images = data['images'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: PageView.builder(
            itemCount: _images.length,
            itemBuilder: (context, index) {
              final image = _images[index];
              return Image.network(image['image_path']);
            },
          ),
        ),
      ),
    );
  }
}