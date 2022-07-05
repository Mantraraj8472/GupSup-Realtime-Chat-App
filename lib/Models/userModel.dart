class UserModel {
  late String? uid;
  late String? name;
  late String? email;
  late String? profilePictureURL;
  late String? status;
  late bool? isGroup = false;

  UserModel(
      {this.uid,
      this.name,
      this.email,
      this.profilePictureURL,
      this.status,
      this.isGroup});

  // data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      profilePictureURL: map['profilePictureURL'],
    );
  }

  // Sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePictureURL': profilePictureURL,
    };
  }
}
