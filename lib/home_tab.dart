import 'package:flutter/material.dart';
import 'product.dart';
import 'product_dao.dart';
import 'product_card.dart';

class HomeTab extends StatefulWidget {
  final void Function(Product) onProductSelected;

  const HomeTab({super.key, required this.onProductSelected});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _dao = ProductDAO();
  late List<Product> _products;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _products = _dao.getAllProduct();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _products = query.trim().isEmpty
          ? _dao.getAllProduct()
          : _dao.findProductByName(query.trim());
    });
  }

  int _crossAxisCount(double width, Orientation orientation) {
    if (width <= 500) {
      return orientation == Orientation.portrait ? 1 : 2;
    } else {
      return orientation == Orientation.portrait ? 2 : 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey[200]!,
      child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearch,
            decoration: InputDecoration(
              hintText: 'Search Products',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _onSearch('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 12,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
        ),
        Expanded(child: _buildList()),
      ],
      ),
    );
  }

  Widget _buildList() {
    if (_products.isEmpty) {
      return const Center(
        child: Text(
          'Không tìm thấy sản phẩm',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final count = _crossAxisCount(constraints.maxWidth, orientation);

            if (count == 1) {
              return ListView.builder(
                itemCount: _products.length,
                itemBuilder: (_, i) => ProductCard(
                  product: _products[i],
                  horizontal: true,
                  onTap: () => widget.onProductSelected(_products[i]),
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: count,
                childAspectRatio: 0.68,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _products.length,
              itemBuilder: (_, i) => ProductCard(
                product: _products[i],
                onTap: () => widget.onProductSelected(_products[i]),
              ),
            );
          },
        );
      },
    );
  }
}
