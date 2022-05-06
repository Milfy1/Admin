class Owner {
  String uid;
  String name;
  String email;
  Owner({required this.email, required this.name, required this.uid});

  factory Owner.fromjson(Map<String, dynamic> data, String uid) {
    return Owner(
      email: data['email'],
      name: data['name'],
      uid: uid,
    );
  }
}
