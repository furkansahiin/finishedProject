class User {
  int userId;
  String username;
  String email;
  String password;
  String image;
  bool isAdmin;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.image,
    required this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
  return User(
    userId: int.tryParse(json['user_id']) ?? 0,// userId null ise 0 olarak ayarlanır
    username: json['username'] ?? '',
    email: json['email'] ?? '',
    password: json['password'] ?? '',
    image: json['image'] ?? '',
    isAdmin: json['is_admin'] == 'false' // string'i bool'a dönüştürüyoruz
    
  );
}

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId.toString(),
      'username': username,
      'email': email,
      'password': password,
      'image': image,
      'is_admin': isAdmin.toString(),
    };
  }
}