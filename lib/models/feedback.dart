class FeedbackClass {
  final String id, text, stars;
  FeedbackClass({this.id, this.text, this.stars});

  factory FeedbackClass.fromJson(Map<String, dynamic> json) {
    return FeedbackClass(
        id: json['id'], text: json['text'], stars: json['stars']);
  }
}
