class RemainingWallet {
  final int result;
  final double walletamount;
  final String message;

  RemainingWallet({this.result, this.walletamount, this.message});

  factory RemainingWallet.fromJson(Map<String, dynamic> json) {
    return RemainingWallet(
        result: json['result'],
        walletamount: json["walletamount"] is int
            ? (json['walletamount'] as int).toDouble()
            : json['walletamount'],
        message: json['message']);
  }
}
