class API {
  static const String HOSTCONNECT = "http://192.168.1.111/bidspace";

  static const String HOSTCONNECTUSER = "$HOSTCONNECT/user";
  static const String HOSTCONNECTHOMEPAGE = "$HOSTCONNECT/homepage";
  static const String HOSTCONNECTAUCTIONS = "$HOSTCONNECT/auctions";


  // USER SİGNUP
  static const String validateEmail = "$HOSTCONNECTUSER/validate_email.php";
  static const String signUp = "$HOSTCONNECTUSER/signup.php";

  // USER LOGIN
  static const String login = "$HOSTCONNECTUSER/login.php";

  // HOMEPAGE SLIDER
  static const String slider = "$HOSTCONNECTHOMEPAGE/sliderimages.php";
  static const String categorylist = "$HOSTCONNECTHOMEPAGE/categorylist.php";
  static const String productlist = "$HOSTCONNECTHOMEPAGE/productlist.php";
  // static const String adsslider = "$HOSTCONNECTHOMEPAGE/adsslider.php";

  // AUCTION
  static const String auctionlist = "$HOSTCONNECTAUCTIONS/auctionlist.php";


}
