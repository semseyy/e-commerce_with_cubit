class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['title'] ?? "", // API'de isim alanı 'title' olarak adlandırılmış olabilir
      description: json['description'] ?? "",
      price: json['price'] != null ? double.parse(json['price'].toString()) : 0.0,
      category: json['category'] ?? "",
      imageUrl: json['image'] ?? "", // Resim URL'si olarak gelmesi bekleniyor
    );
  }
}
