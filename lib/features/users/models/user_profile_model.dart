class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String birthday;
  final String bio;
  final String link;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.birthday,
    required this.bio,
    required this.link,
  });
  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        birthday = "",
        bio = "",
        link = "";
  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "birthday": birthday,
      "bio": bio,
      "link": link,
    };
  }
}
