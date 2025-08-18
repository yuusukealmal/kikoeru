class Translatebonuslangsclass {
  Translatebonuslangsclass({required this.translateBonusLangsDetail}) {
    price = translateBonusLangsDetail["price"] ?? 0;
    status = translateBonusLangsDetail["status"] ?? "";
    priceTax = translateBonusLangsDetail["price_tax"] ?? 0;
    childCount = translateBonusLangsDetail["child_count"] ?? 0;
    priceInTax = translateBonusLangsDetail["price_in_tax"] ?? 0;
    recipientMax = translateBonusLangsDetail["recipient_max"] ?? 0;
    recipientAvailableCount =
        translateBonusLangsDetail["recipient_available_count"] ?? 0;
  }

  final Map<String, dynamic> translateBonusLangsDetail;
  late final int price;
  late final String status;
  late final int priceTax;
  late final int childCount;
  late final int priceInTax;
  late final int recipientMax;
  late final int recipientAvailableCount;
}
