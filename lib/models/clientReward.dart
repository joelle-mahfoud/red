class ClientReward {
  final double amount;
  final int result;
  final String message;
  ClientReward({this.amount, this.result, this.message});

  factory ClientReward.fromJson(Map<String, dynamic> json) {
    return ClientReward(
        amount: json["amount"] is int
            ? (json['amount'] as int).toDouble()
            : json['amount'],
        // amount: (json.containsKey(json['amount']) ? json['amount'] : 0),
        message: json['message'],
        result: json['result']);
  }
}
