class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double? discount;
  final int stock;
  final double rating;
  final bool isPopular;
  final bool isDiscounted;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.discount,
    required this.stock,
    this.rating = 0.0,
    this.isPopular = false,
    this.isDiscounted = false,
  });

  factory Product.fromMap(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      category: data['category'] ?? '',
      discount: (data['discount'] ?? 0.0).toDouble(),
      stock: data['stock'] ?? 0,
      rating: (data['rating'] ?? 0.0).toDouble(),
      isPopular: data['isPopular'] ?? false,
      isDiscounted: data['isDiscounted'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'discount': discount,
      'stock': stock,
      'rating': rating,
      'isPopular': isPopular,
      'isDiscounted': isDiscounted,
    };
  }

  double get discountedPrice {
    return discount != null ? price * (1 - discount!) : price;
  }
}