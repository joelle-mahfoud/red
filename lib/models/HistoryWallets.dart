class HistoryWallets {
  final String id,
      type,
      amount,
      listingId,
      listingTitle,
      startDate,
      endDate,
      unitPrice,
      quantity,
      totalPrice;
  HistoryWallets(
      {this.id,
      this.type,
      this.amount,
      this.listingId,
      this.listingTitle,
      this.startDate,
      this.endDate,
      this.unitPrice,
      this.quantity,
      this.totalPrice});

  factory HistoryWallets.fromJson(Map<String, dynamic> json) {
    return HistoryWallets(
        id: json['id'] ?? "",
        type: json['type'] ?? "",
        amount: json['amount'] ?? "",
        listingId: json['listing_id'] ?? "",
        listingTitle: json['listing_title'] ?? "",
        startDate: json['start_date'] ?? "",
        endDate: json['end_date'] ?? "",
        unitPrice: json['unit_price'] ?? "",
        quantity: json['quantity'] ?? "",
        totalPrice: json['total_price'] ?? "");
  }
}
