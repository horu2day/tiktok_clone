class ChatModel {
  final String id;
  final String thumbnailUrl1;
  final String personA;
  final String personB;

  final int createdAt;
  ChatModel(
      {required this.id,
      required this.thumbnailUrl1,
      required this.personA,
      required this.personB,
      required this.createdAt});

  ChatModel.fromJson(
      {required Map<String, dynamic> json, required String chatId})
      : thumbnailUrl1 = json["thumbnailUrl1"],
        personA = json["personA"],
        personB = json["personB"],
        id = chatId,
        createdAt = json["createdAt"];

  Map<String, dynamic> toJson() {
    return {
      "thumbnailUrl1": thumbnailUrl1,
      "personA": personA,
      "personB": personB,
      "createdAt": createdAt,
      "id": id,
    };
  }
}
