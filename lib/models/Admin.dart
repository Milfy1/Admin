class Admin {
  String uid;
  String initPassword;
  String email;
  Admin({required this.email, required this.initPassword, required this.uid});

  factory Admin.fromjson(Map<String, dynamic> data) {
    return Admin(
        email: data['email'], initPassword: data['name'], uid: data['uid']);
  }
}
