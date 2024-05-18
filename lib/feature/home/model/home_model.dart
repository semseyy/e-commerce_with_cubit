class Product {
  final int id;
  final String name;
  final String description;
  final double? price;
  final String category;
  final String imageUrl;
  final double? rating;
  final int? ratingCount;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    this.price,
    this.rating,
    this.ratingCount,
    required this.quantity,
  });

  // JSON verisini Product nesnesine dönüştüren fromJson metodu
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      imageUrl: json['image'] as String,
      price: json['price'] != null ? double.parse(json['price'].toString()) : null,
      rating: (json['rating'] != null && json['rating']['rate'] != null)
          ? double.parse(json['rating']['rate'].toString())
          : null,
      ratingCount: (json['rating'] != null && json['rating']['count'] != null)
          ? int.parse(json['rating']['count'].toString())
          : null,
      quantity: json['quantity'] != null
          ? json['quantity'] as int
          : 1, // JSON'da 'quantity' alanı varsa, onu kullan; yoksa varsayılan olarak 1 ata
    );
  }
}
