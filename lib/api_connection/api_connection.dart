class API {
  static const hostConnect = "http://192.168.56.1/jewelry";
  static const hostConnectUser = "$hostConnect/Users";
  static const hostConnectAdmin = "$hostConnect/admin";
  static const hostConnectProduct = "$hostConnect/products";

//signup and login Users
  static const validateEmail = "$hostConnectUser/validate_email.php";
  static const signUp = "$hostConnectUser/signup.php";
  static const login = "$hostConnectUser/login.php";

//login admin
  static const adminLogin = "$hostConnectAdmin/login.php";

//admin upload new product
  static const uploadNewItem = "$hostConnectProduct/upload.php";

//products
  static const getTrendingMostPopulerProducts =
      "$hostConnectProduct/Trending.php";

//all collections
  static const getAllProducts = "$hostConnectProduct/all.php";
}
