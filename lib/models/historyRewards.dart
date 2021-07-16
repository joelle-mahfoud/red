class HistoryRewards {
  final String id,
      type,
      amount,
      listingId,
      listingTitle,
      date_used,
      startDate,
      endDate,
      unitPrice,
      quantity,
      totalPrice;
  HistoryRewards(
      {this.id,
      this.type,
      this.amount,
      this.listingId,
      this.listingTitle,
      this.date_used,
      this.startDate,
      this.endDate,
      this.unitPrice,
      this.quantity,
      this.totalPrice});

  factory HistoryRewards.fromJson(Map<String, dynamic> json) {
    return HistoryRewards(
        id: json['id'] ?? "",
        type: json['type'] ?? "",
        amount: json['amount'] ?? "",
        listingId: json['listing_id'] ?? "",
        listingTitle: json['listing_title'] ?? "",
        date_used: json['date_used'] ?? "",
        startDate: json['start_date'] ?? "",
        endDate: json['end_date'] ?? "",
        unitPrice: json['unit_price'] ?? "",
        quantity: json['quantity'] ?? "",
        totalPrice: json['total_price'] ?? "");
  }
}
