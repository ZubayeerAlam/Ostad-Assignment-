import 'package:flutter/material.dart';

import '../models/product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const List<String> categories = [
    'All',
    'Clothes',
    'Fashion',
    'Accessories',
  ];
  static const int discountThreshold = 3000;
  static const double discountRate = 0.10;

  final List<Product> _products = getProducts();
  final TextEditingController _searchController = TextEditingController();

  String _searchText = '';
  String _selectedCategory = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Search (case-insensitive) and category filter applied together.
  List<Product> get _filteredProducts {
    final query = _searchText.trim().toLowerCase();
    return _products.where((p) {
      final matchesSearch =
          query.isEmpty || p.name.toLowerCase().contains(query);
      final matchesCategory =
          _selectedCategory == 'All' || p.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  // Totals are calculated from all products, not only the visible ones,
  // so filtering never changes what is in the cart.
  int get _totalItems => _products.fold(0, (sum, p) => sum + p.quantity);

  int get _subtotal =>
      _products.fold(0, (sum, p) => sum + p.price * p.quantity);

  double get _discount =>
      _subtotal >= discountThreshold ? _subtotal * discountRate : 0;

  double get _grandTotal => _subtotal - _discount;

  void _increase(Product product) {
    setState(() => product.quantity++);
  }

  void _decrease(Product product) {
    if (product.quantity == 0) return; // quantity can't go below 0
    setState(() => product.quantity--);
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Shopping Cart'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchText.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchText = '');
                              },
                            ),
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (value) => setState(() => _searchText = value),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _selectedCategory,
                  items: categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _selectedCategory = value);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: products.isEmpty
                ? const Center(
                    child: Text(
                      'No matching products found',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) =>
                        _buildProductCard(products[index]),
                  ),
          ),
          _buildSummary(),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Price: ৳${product.price}'),
                  Text('Category: ${product.category}'),
                ],
              ),
            ),
            IconButton.filledTonal(
              icon: const Icon(Icons.remove),
              onPressed:
                  product.quantity == 0 ? null : () => _decrease(product),
            ),
            SizedBox(
              width: 36,
              child: Text(
                '${product.quantity}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            IconButton.filledTonal(
              icon: const Icon(Icons.add),
              onPressed: () => _increase(product),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Card(
      margin: const EdgeInsets.all(12),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _summaryRow('Total Items', '$_totalItems'),
            _summaryRow('Subtotal', '৳$_subtotal'),
            _summaryRow('Discount', '- ৳${_discount.toStringAsFixed(2)}'),
            const Divider(),
            _summaryRow(
              'Grand Total',
              '৳${_grandTotal.toStringAsFixed(2)}',
              bold: true,
            ),
            if (_discount == 0)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Spend ৳$discountThreshold or more to get 10% off',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    final style = TextStyle(
      fontSize: bold ? 18 : 15,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      ),
    );
  }
}
