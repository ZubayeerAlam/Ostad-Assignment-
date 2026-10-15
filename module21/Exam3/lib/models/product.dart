class Product {
  final String name;
  final int price;
  final String category;
  int quantity;

  Product({
    required this.name,
    required this.price,
    required this.category,
    this.quantity = 0,
  });
}

// Local data only — no API / database.
List<Product> getProducts() => [
      Product(name: 'T-Shirt', price: 500, category: 'Clothes'),
      Product(name: 'Shoes', price: 1500, category: 'Fashion'),
      Product(name: 'Watch', price: 2000, category: 'Accessories'),
      Product(name: 'Bag', price: 1000, category: 'Fashion'),
    ];
