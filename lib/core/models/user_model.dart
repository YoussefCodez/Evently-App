class UserModel {
  String? name;
  String? email;
  String? uid;
  List<String>? favorites;
  UserModel({this.name, this.email, this.uid, this.favorites});
  factory UserModel.fromDocument(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] ?? "",
      email: data['email'] ?? "",
      uid: data['uid'] ?? "",
      favorites: (data["favorites"] as List?)?.cast<String>() ?? [],
    );
  }
  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'favorites': favorites,
    };
  }
}