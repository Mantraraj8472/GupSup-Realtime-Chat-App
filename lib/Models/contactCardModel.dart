class ContactCardModel {
  late String name;
  late String profilePic;
  late String status;
  bool isSelected = false;

  ContactCardModel({
    required this.name,
    required this.profilePic,
    required this.status,
    this.isSelected = false,
  });
}
