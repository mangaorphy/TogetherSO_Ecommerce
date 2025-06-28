import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../providers/product_provider.dart';
import '../screens/cart_screen.dart';
import '../screens/profile_screen.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  final List<Widget> _tabs = [
    ForYouTab(),
    PopularTab(),
    CheapestTab(),
    DiscountTab(),
  ];

  void _onItemTapped(int index, BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    if (index == 2) {
      // Navigate to CartScreen when Cart is tapped
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CartScreen()),
      );
    } else if (index == 4) {
      // Navigate to ProfileScreen when Profile is tapped
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } else {
      appProvider.updateIndex(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TogetherSO",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Type whatever you want",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onSubmitted: (text) {
                        appProvider.addToSearchHistory(text);
                        _searchController.clear();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        if (_searchController.text.isNotEmpty) {
                          appProvider.addToSearchHistory(_searchController.text);
                          print("Searching for: ${_searchController.text}");
                          _searchController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ⏳ Search History
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "History",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      appProvider.clearSearchHistory();
                    },
                    child: Text("Clear", style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: appProvider.searchHistory.map((term) {
                return Chip(
                  label: Text(term),
                  onDeleted: () {
                    appProvider.removeSearchTerm(term);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 8),

            // Show More Button
            Center(
              child: TextButton(
                onPressed: () {
                  print("Show More");
                },
                child: Text("Show More", style: TextStyle(color: Colors.green)),
              ),
            ),

            const SizedBox(height: 16),

            // 📂 Tab Bar
            DefaultTabController(
              initialIndex: appProvider.selectedIndex,
              length: 4,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: TabBar(
                      labelColor: Colors.green,
                      indicatorColor: Colors.green,
                      unselectedLabelStyle:
                          TextStyle(color: Colors.black54),
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 3,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(text: "For You"),
                        Tab(text: "Popular"),
                        Tab(text: "Cheapest"),
                        Tab(text: "Discount"),
                      ],
                    ),
                  ),

                  // Tab Views
                  SizedBox(
                    height: 400,
                    child: TabBarView(children: _tabs),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // 🛒 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: appProvider.selectedIndex,
        onTap: (index) => _onItemTapped(index, context),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Products",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favourites",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class ForYouTab extends StatelessWidget {
  const ForYouTab({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).products;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(product: product);
      },
    );
  }
}

class PopularTab extends StatelessWidget {
  const PopularTab({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).popularProducts;

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          leading: Image.network(product.imageUrl, width: 50, height: 50),
          title: Text(product.name),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          trailing: const Icon(Icons.star, color: Colors.amber),
        );
      },
    );
  }
}

class CheapestTab extends StatelessWidget {
  const CheapestTab({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).cheapestProducts;

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          leading: Image.network(product.imageUrl, width: 50, height: 50),
          title: Text(product.name),
          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
        );
      },
    );
  }
}

class DiscountTab extends StatelessWidget {
  const DiscountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Discounted Items"));
  }
}
