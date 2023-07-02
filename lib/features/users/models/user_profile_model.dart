class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final String birthday;
  final String bio;
  final String link;
  final bool hasAvatar;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.birthday,
    required this.bio,
    required this.link,
    required this.hasAvatar,
  });
  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        birthday = "",
        bio = "",
        link = "",
        hasAvatar = false;

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        email = json["email"],
        name = json["name"],
        birthday = json["birthday"],
        bio = json["bio"],
        hasAvatar = json["hasAvatar"],
        link = json["link"];

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "birthday": birthday,
      "bio": bio,
      //"hasAvatar": hasAvatar,
      "link": link,
    };
  }

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? birthday,
    String? bio,
    String? link,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
