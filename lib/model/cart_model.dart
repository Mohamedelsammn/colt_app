class CartItem {
  final int productId;
  final String title;
  final double price;
  final String size;
  final String color;
  final String image;
  int quantity;

  CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.size,
    required this.color,
    required this.image,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'title': title,
    'price': price,
    'size': size,
    'color': color,
    'quantity': quantity,
    'images': image,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    image: json['images'],
    productId: json['productId'],
    title: json['title'],
    price: json['price'],
    size: json['size'],
    color: json['color'],
    quantity: json['quantity'],
  );
}
