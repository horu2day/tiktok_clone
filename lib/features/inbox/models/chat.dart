class ChatModel {
  final String id;
  final String personA;
  final String personB;
  final int createdAt;
  ChatModel(
      {required this.id,
      required this.personA,
      required this.personB,
      required this.createdAt});

  ChatModel.fromJson(
      {required Map<String, dynamic> json, required String chatId})
      : personA = json["personA"],
        personB = json["personB"],
        id = chatId,
        createdAt = json["createdAt"];

  Map<String, dynamic> toJson() {
    return {
      "personA": personA,
      "personB": personB,
      "createdAt": createdAt,
      "id": id,
    };
  }
}
