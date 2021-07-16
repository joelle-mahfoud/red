class Feedbacklink {
  final String id, IosLink, AndroidLink;
  Feedbacklink({this.id, this.IosLink, this.AndroidLink});

  factory Feedbacklink.fromJson(Map<String, dynamic> json) {
    return Feedbacklink(
        id: json['id'],
        IosLink: json['ios_link'],
        AndroidLink: json['android_link']);
  }
}
