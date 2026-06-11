import 'package:flutter/material.dart';
import 'product.dart';
import 'home_tab.dart';
import 'product_detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  Product? _selectedProduct;

  static const _titles = ['Products', 'Product Detail', 'Cart'];

  void _onProductSelected(Product product) {
    setState(() {
      _selectedProduct = product;
      _currentIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_titles[_currentIndex]),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: _currentIndex == 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => setState(() => _currentIndex = 0),
              )
            : null,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeTab(onProductSelected: _onProductSelected),
          _selectedProduct != null
              ? ProductDetailScreen(
                  product: _selectedProduct!,
                  showAsScreen: false,
                )
              : const Center(
                  child: Text(
                    'Chọn sản phẩm để xem chi tiết',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
          const Center(child: Text('Cart', style: TextStyle(fontSize: 22))),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            activeIcon: Icon(Icons.list),
            label: 'ProductDetail',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
