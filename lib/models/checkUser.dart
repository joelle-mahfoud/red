class CheckUser {
  final String message;
  final int result;
  final int userInactive;
  final DateTime expires;
  final int daysLeft;
  CheckUser(
      {this.result,
      this.userInactive,
      this.expires,
      this.message,
      this.daysLeft});

  factory CheckUser.fromJson(Map<String, dynamic> json) {
    return CheckUser(
        result: json['result'],
        userInactive:
            json.containsKey('user_inactive') ? json['user_inactive'] : null,
        daysLeft: json.containsKey('daysLeft') ? json['daysLeft'] : null,
        message: json.containsKey('message') ? json['message'] : null,
        expires: json.containsKey('expires')
            ? DateTime.parse(json['expires'])
            : null);
  }
}
