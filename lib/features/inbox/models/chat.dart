class ChatModel {
  final String id;
  final String personA;
  final String personAName;
  final String personABio;
  final String personB;
  final int createdAt;
  ChatModel(
      {required this.id,
      required this.personA,
      required this.personAName,
      required this.personABio,
      required this.personB,
      required this.createdAt});

  ChatModel.fromJson(
      {required Map<String, dynamic> json, required String chatId})
      : personA = json["personA"],
        personAName = json["personAName"],
        personABio = json["personABio"],
        personB = json["personB"],
        id = chatId,
        createdAt = json["createdAt"];

  Map<String, dynamic> toJson() {
    return {
      "personA": personA,
      "personAName": personAName,
      "personABio": personABio,
      "personB": personB,
      "createdAt": createdAt,
      "id": id,
    };
  }
}
