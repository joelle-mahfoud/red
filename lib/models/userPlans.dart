class UserPlans {
  final String id, titleEn, cardImg, endDate, trial, price, package_id;
  final DateTime expiryDate, purchacedDate;
  UserPlans(
      {this.id,
      this.package_id,
      this.titleEn,
      this.cardImg,
      this.purchacedDate,
      this.endDate,
      this.trial,
      this.expiryDate,
      this.price});

  factory UserPlans.fromJson(Map<String, dynamic> json) {
    return UserPlans(
        id: json['id'],
        package_id: json['package_id'],
        titleEn: json['title_en'],
        cardImg: json['card_img'],
        purchacedDate: DateTime.parse(json['purchaced_date']),
        endDate: json['end_date'],
        trial: json['trial'],
        expiryDate: DateTime.parse(json['expiry_date']),
        price: json['price']);
  }
}
