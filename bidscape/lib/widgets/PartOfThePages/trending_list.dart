import 'package:http/http.dart' as http;
import 'package:bidscape/consts/consts.dart';

class TrendingListScreen extends StatefulWidget {
  const TrendingListScreen({Key? key});

  @override
  State<TrendingListScreen> createState() => _TrendingListScreenState();
}

class _TrendingListScreenState extends State<TrendingListScreen> {
  List<Product> _trendlist = [];

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
        final auctionsData =
            json.decode(auctionsResponse.body)['auctions'] as List<dynamic>;

        // auctionsData'dan çekilen product_id'leri içeren ürünleri getirin
        final productIds =
            auctionsData.map((auction) => auction['product_id']).toList();
        final productsResponse = await http.get(Uri.parse(
            "${API.productlist}?product_id=${productIds.join(',')}"));

        if (productsResponse.statusCode == 200) {
            if (json.decode(productsResponse.body)['success'] == true) {
              final productsData =
                  json.decode(productsResponse.body)['products'] as List<dynamic>;

              // ilk 5 ürünü ayıklayın ve setState ile güncelleyin
              // final filteredTrendsData = productsData.where((element) => (element['view_count'])).toList().reversed.take(5).toList();
              final filteredTrendsData = productsData.where((element) => element['view_count'].isNotEmpty).toList().sortedBy((a, b) => int.parse(b['view_count']).compareTo(int.parse(a['view_count']))).take(5).toList();
              setState(() {
                _trendlist =
                    filteredTrendsData.map((product) => Product.fromJson(product)).toList();
              });
            }
          }
        } else {
          setState(() {
            _trendlist = [];
          });
        }
    }
    }
     catch (e) {
      Get.snackbar(
        
        'Hata',
        'Trend Ürünler yüklenirken bir hata oluştu: $e',
        backgroundColor: errorred,
        colorText: whiteColor,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         "Trend Ürünler".text.xl.bold.color(appcolorred).make().marginOnly(left: 10),
        10.heightBox,
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: _trendlist.isEmpty
              ? CircularProgressIndicator().box.makeCentered()
              : PageView.builder(
                  itemCount: _trendlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
        children: [GestureDetector(
          onTap: () {
            // Get.to(() => ProductDetail(title: _productsList[index]));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.network(
                _trendlist[index].image,
                width: 150,
                fit: BoxFit.fill,
              ),
              10.widthBox,
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: _trendlist[index].title.text.size(10).make()),
                    5.heightBox,
                    Expanded(child:_trendlist[index].description.text.size(10).make()),
                    5.heightBox,
                    Expanded(child: _trendlist[index].createDate.toString().text.size(10).make()),
                    5.heightBox,
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _trendlist[index].categoryId.toString().text.size(10).make(),
                          2.widthBox,
                          _trendlist[index].isSponsored.toString().text.size(10).make(),
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
          top: 10,
          right: 10,
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
                  },
                ),
        ),
      ],
    );
  }
}