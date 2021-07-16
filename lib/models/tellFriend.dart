class TellFriend {
  final String id, tellFriend;
  TellFriend({this.id, this.tellFriend});

  factory TellFriend.fromJson(Map<String, dynamic> json) {
    return TellFriend(id: json['id'], tellFriend: json['tell_friend']);
  }
}
