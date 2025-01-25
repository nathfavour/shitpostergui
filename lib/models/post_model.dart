class Post {
  final String id;
  final String content;
  final DateTime scheduledTime;

  Post({required this.id, required this.content, required this.scheduledTime});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      content: json['content'],
      scheduledTime: DateTime.parse(json['scheduledTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'scheduledTime': scheduledTime.toIso8601String(),
    };
  }
}
