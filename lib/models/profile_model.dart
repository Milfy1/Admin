class ProfileModel {
  String? userName;
  String? userImage;
  String? email;

  ProfileModel(
    this.userName,
    this.userImage,
    this.email,
  );

  ProfileModel.fromJson(Map<String, dynamic> json) {
    userName = json['name'];
    userImage = json['profilePicture'];
    email = json['email'];
  }
}
