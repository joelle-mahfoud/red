class UserRewards {
  final double rewardpoint, walletAmount;
  UserRewards({this.rewardpoint, this.walletAmount});

  factory UserRewards.fromJson(Map<String, dynamic> json) {
    return UserRewards(
      rewardpoint: json["rewardpoint"] is int
          ? (json['rewardpoint'] as int).toDouble()
          : json['rewardpoint'],
      walletAmount: json["walletamount"] is int
          ? (json['walletamount'] as int).toDouble()
          : json['walletamount'],
    );
  }
}
