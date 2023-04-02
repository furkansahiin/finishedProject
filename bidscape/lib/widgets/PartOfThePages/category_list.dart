import 'package:bidscape/consts/consts.dart';
import 'package:http/http.dart' as http;

class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  List<Category> _categoryList = [];
  List<Product> _productsList = [];
  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(API.categorylist));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List;
      setState(() {
        _categoryList =
            jsonData.map((category) => Category.fromJson(category)).toList();
      });
    } 
    }
    catch (e) {
      Get.snackbar(errorTitle, "Kategoriler yüklenemedi" , snackPosition: SnackPosition.BOTTOM, backgroundColor: errorred, colorText: whiteColor);
    }
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchProductsByCategory(int categoryId) async {
    try {
      final auctionsResponse = await http.get(Uri.parse(API.auctionlist));
      if (auctionsResponse.statusCode == 200) {
        if (json.decode(auctionsResponse.body)['success'] == true) {
          final auctionsData = json.decode(auctionsResponse.body)['auctions'] as List<dynamic>;
          
          // auctionsData'dan çekilen product_id'leri içeren ürünleri getirin
          final productIds = auctionsData.map((auction) => auction['product_id']).toList();
          final productsResponse = await http.get(Uri.parse("${API.productlist}?product_id=${productIds.join(',')}"));
          
          if (productsResponse.statusCode == 200) {
            if (json.decode(productsResponse.body)['success'] == true) {
              final productsData = json.decode(productsResponse.body)['products'] as List<dynamic>;
              
              // category_id'yi içeren ürünleri ayıklayın ve setState ile güncelleyin
              final filteredProductsData = categoryId == 1 ? productsData : productsData.where((product) => product['category_id'].toString() == categoryId.toString()).toList();
              setState(() {
                _productsList = filteredProductsData.map((product) => Product.fromJson(product)).toList();
              });
              
            }
          }
        }
        else {
          setState(() {
            _productsList = [];
          });
        }
      } 
    }
    catch (e) {
      Get.snackbar(errorTitle, "Ürünler yüklenemedi", snackPosition: SnackPosition.BOTTOM, backgroundColor: errorred, colorText: whiteColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_productsList.length == 0) {
      _fetchProductsByCategory(1);
    }
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoriesName.text.xl.bold.color(appcolorred).make().marginOnly(left: 10),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                    _fetchProductsByCategory(_categoryList[index].categoryId);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Image.network(
                            _categoryList[index].image,
                            fit: BoxFit.fill,)
                        ),
                        SizedBox(height: 5),
                        Text(
                          _categoryList[index].name,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          selectedCategoryIndex == 0 ? allCategory.text.xl.bold.color(appcolorred).make().marginOnly(left: 10) : _categoryList[selectedCategoryIndex].name.text.xl.bold.color(appcolorred).make().marginOnly(left: 10) ,
          5.heightBox,
        _productsList.length > 0 ? ProductListter(productsList: _productsList) : CircularProgressIndicator(),
                        
          ],
      ),
    );
  }
}

class ProductListter extends StatelessWidget {
  const ProductListter({
    super.key,
    required List<Product> productsList,
  }) : _productsList = productsList;

  final List<Product> _productsList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: _productsList.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 5,   
      mainAxisExtent: 220,
    ),
    itemBuilder: (context, index) {
      return Stack(
        children: [GestureDetector(
          onTap: () {
            // Get.to(() => ProductDetail(title: _productsList[index]));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.network(
                _productsList[index].image,
                height: 100,
                fit: BoxFit.fill,
              ),
              10.heightBox,
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: _productsList[index].title.text.size(10).make()),
                    5.heightBox,
                    Expanded(child:_productsList[index].description.text.size(10).make()),
                    5.heightBox,
                    Expanded(child: _productsList[index].createDate.toString().text.size(10).make()),
                    5.heightBox,
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _productsList[index].categoryId.toString().text.size(10).make(),
                          2.widthBox,
                          _productsList[index].isSponsored.toString().text.size(10).make(),
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
    });
  }
}
