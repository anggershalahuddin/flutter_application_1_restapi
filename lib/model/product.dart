class Product {
  int id;
  String title;
  String description;
  int price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  String images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromMap(Map<String, dynamic> map) => Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      discountPercentage: map['discountPercentage'],
      rating: map['rating'],
      stock: map['stock'],
      brand: map['brand'],
      category: map['category'],
      thumbnail: map['thumbnail'],
      images: map['images']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'stock': stock,
        'brand': brand,
        'category': category,
        'thumbnail': thumbnail,
        'images': images
      };
}
