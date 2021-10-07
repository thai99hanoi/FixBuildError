class Message {
  String userName;
  String content;

  Message(this.userName, this.content);

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(json['userName'] as String, json['content'] as String);
}
