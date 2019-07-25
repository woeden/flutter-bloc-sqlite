class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'],
        body = json['body'];

  Map<String, dynamic> toMap({id}) {
    if (id != null) {
      return {
        'id': id,
        'userId': userId,
        'title': title,
        'body': body,
      };
    } else {
      return {
        'userId': userId,
        'title': title,
        'body': body,
      };
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return id.toString();
  }
}
