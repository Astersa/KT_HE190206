class Product {
  int id;
  String description;
  String detail;
  double price;
  double discontPercen;
  String image;
  double rating;
  int reviewCount;

  Product({
    required this.id,
    required this.description,
    required this.detail,
    required this.price,
    required this.discontPercen,
    required this.image,
    this.rating = 0,
    this.reviewCount = 0,
  });

  double get discountedPrice => price * (1 - discontPercen / 100);
}
