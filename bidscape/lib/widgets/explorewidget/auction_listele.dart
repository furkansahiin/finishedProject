import 'package:http/http.dart' as http;
import 'package:bidscape/consts/consts.dart';

class ExploreListScreen extends StatefulWidget {
  const ExploreListScreen({Key? key});

  @override
  State<ExploreListScreen> createState() => _ExploreListScreenState();
}

class _ExploreListScreenState extends State<ExploreListScreen> {
  List<Product> _exploreList = [];

  @override
  void initState() {
    super.initState();
    _fetchTrendsList();
  }

  Future<void> _fetchTrendsList() async {
    try {
    final auctionsResponse = await http.get(Uri.parse(API.auctionlist));
    if (auctionsResponse.statusCode == 200) {
          if (json.decode(auctionsResponse.body)['success'] == true) {
        final auctionsData = json.decode(auctionsResponse.body)['auctions'] as List<dynamic>;

        // Get products containing product_ids extracted from auctionsData
        final expiringAuctions = auctionsData.where((auction) {
          final endTime = DateTime.parse(auction['end_time']);
          final difference = endTime.difference(DateTime.now());
          return difference.inDays < 2 && difference.inMilliseconds > 0;
        }).toList();

        final productIds = expiringAuctions.map((auction) => auction['product_id']).toList();
        final productsResponse = await http.get(Uri.parse("${API.productlist}?product_id=${productIds.join(',')}"));

        if (productsResponse.statusCode == 200) {
          if (json.decode(productsResponse.body)['success'] == true) {
            final productsData = json.decode(productsResponse.body)['products'] as List<dynamic>;

            // Filter the first 5 products and update the state with setState
            setState(() {
              _exploreList = productsData.map((product) => Product.fromJson(product)).take(5).toList();
            });
          }
        } else {
          setState(() {
            _exploreList = [];
          });
        }
      }
    }
      else {
      setState(() {
        _exploreList = [];
      });
    }
  }
  
  catch (e) {
  Get.snackbar(
    'Hata',
    'Ürünler yüklenirken bir hata oluştu: $e',
    backgroundColor: errorred,
    colorText: whiteColor,
    duration: const Duration(seconds: 3),
  );
}
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
           "Keşfet".text.xl.bold.color(appcolorred).make().marginOnly(left: 10),
          10.heightBox,
          _exploreList.isEmpty
              ? CircularProgressIndicator()
              : GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _exploreList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 5,     
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  GestureDetector(
                  onTap: () {
                    // Get.to(() => ProductDetail(title: _productsList[index]));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.network(
                        _exploreList[index].image,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                      10.heightBox,
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                                child: _exploreList[index].title.text.size(10).make()),
                            5.heightBox,
                            Expanded(child:_exploreList[index].description.text.size(10).make()),
                            5.heightBox,
                            Expanded(child: _exploreList[index].createDate.toString().text.size(10).make()),
                            5.heightBox,
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _exploreList[index].categoryId.toString().text.size(10).make(),
                                  2.widthBox,
                                  _exploreList[index].isSponsored.toString().text.size(10).make(),
                                ],
                              ),
                            )),
              
                          ],
                        ),
                      )
            ],
          )
              .box
              .color(lightGrey)
              .margin(marginhorizontal)
              .rounded
              .padding(padding8all)
              .shadow2xl
              .make(),
          ),
          Positioned(
          top: 5,
          right: 5,
          child: IconButton(
          icon: Icon(
            // _productsList[index].isFavorite 
            // ? Icons.favorite 
            Icons.favorite_border_outlined
          ),
          onPressed: () {
            // var productId = _productsList[index].id;
            var userId = 'kullaniciId'; // Burada kullanıcının kimliği olmalı
            // if (_productsList[index].isFavorite) {
              // Favori olarak işaretlenmişse, favorilerden kaldırın
              // removeFromFavorite(userId, productId);
            // } else {
              // Favori olarak işaretlenmemişse, favorilere ekleyin
              // addToFavorite(userId, productId);
            // }
          },
          ),
          ),
          ],
        );
      }),
        ],
      ),
    );
  }
}