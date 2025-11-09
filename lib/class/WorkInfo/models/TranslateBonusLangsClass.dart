class TranslatebonuslangsClass {
  TranslatebonuslangsClass.fromMap(Map<String, dynamic> map) {
    price = map["price"] ?? 0;
    status = map["status"] ?? "";
    priceTax = map["price_tax"] ?? 0;
    childCount = map["child_count"] ?? 0;
    priceInTax = map["price_in_tax"] ?? 0;
    recipientMax = map["recipient_max"] ?? 0;
    recipientAvailableCount = map["recipient_available_count"] ?? 0;
  }

  late final int price;
  late final String status;
  late final int priceTax;
  late final int childCount;
  late final int priceInTax;
  late final int recipientMax;
  late final int recipientAvailableCount;
}
