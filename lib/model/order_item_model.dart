class OrderItemModel {
  final int productId;
  final String title;
  final double price;
  final String color;
  final String size;
  final int quantity;

  OrderItemModel({
    required this.productId,
    required this.title,
    required this.price,
    required this.color,
    required this.size,
    required this.quantity,
  });

  Map<String, dynamic> toJson(dynamic orderId) {
    return {
      'order_id': orderId,
      'product_id': productId,
      'title': title,
      'price': price,
      'color': color,
      'size': size,
      'quantity': quantity,
    };
  }

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['product_id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      color: json['color'],
      size: json['size'],
      quantity: json['quantity'],
    );
  }
}
