class PaymentCard {
  final String? id;
  final String? cardHolderName;
  final String? last4;
  final int expiryMonth;
  final int expiryYear;

  PaymentCard({
    required this.id,
    required this.cardHolderName,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
  });

  factory PaymentCard.fromMap(Map<String, dynamic> map) {
    final cardNumber = map['card_number']?.toString() ?? '';
    final last4 = cardNumber.length >= 4
        ? cardNumber.substring(cardNumber.length - 4)
        : '0000'; // قيمة افتراضية لو الرقم مش موجود

    return PaymentCard(
      id: map['id']?.toString() ?? '',
      cardHolderName: map['cardholder_name'] ?? '',
      last4: last4,
      expiryMonth: map['expiry_month'] ?? 0,
      expiryYear: map['expiry_year'] ?? 0,
    );
  }
}
