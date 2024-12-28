import 'package:flutter/material.dart';
import 'dart:math';
import 'custom_app_bar.dart';
import 'product_details_page.dart';
import 'product_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<IconData> banners = [
    Icons.local_offer,
    Icons.shopping_cart,
    Icons.discount,
  ];

  final List<Map<String, dynamic>> categories = [
    {'name': 'Electronics', 'icon': Icons.devices},
    {'name': 'Clothing', 'icon': Icons.checkroom},
    {'name': 'Home Appliances', 'icon': Icons.kitchen},
    {'name': 'Books', 'icon': Icons.book},
    {'name': 'Sports', 'icon': Icons.sports},
  ];

  final Map<String, List<Map<String, dynamic>>> productsByCategory = {
    'Electronics': [
      {'name': 'Smartphone', 'price': 299.99},
      {'name': 'Laptop', 'price': 999.99},
      {'name': 'Headphones', 'price': 49.99},
    ],
    'Clothing': [
      {'name': 'T-shirt', 'price': 19.99},
      {'name': 'Jeans', 'price': 39.99},
      {'name': 'Jacket', 'price': 89.99},
    ],
    'Home Appliances': [
      {'name': 'Microwave', 'price': 79.99},
      {'name': 'Vacuum Cleaner', 'price': 129.99},
      {'name': 'Refrigerator', 'price': 599.99},
    ],
    'Books': [
      {'name': 'Novel', 'price': 9.99},
      {'name': 'Comics', 'price': 14.99},
      {'name': 'Biography', 'price': 19.99},
    ],
    'Sports': [
      {'name': 'Football', 'price': 24.99},
      {'name': 'Basketball', 'price': 29.99},
      {'name': 'Tennis Racket', 'price': 79.99},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> allProducts = productsByCategory.values
        .expand((products) => products)
        .toList();
    final List<Map<String, dynamic>> randomProducts =
        List.generate(5, (_) => allProducts[Random().nextInt(allProducts.length)]);

    return Scaffold(
      appBar: const CustomAppBar(title: 'E-commerce App'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banners Section
            SizedBox(
              height: 150,
              child: PageView.builder(
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          banners[index],
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Categories Section
            Center(
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsPage(
                              category: category['name'],
                              products: productsByCategory[category['name']] ?? [],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: Icon(category['icon'], size: 30),
                            ),
                            const SizedBox(height: 5),
                            Text(category['name'],
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Text(
                'Featured Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Random Products Section
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: randomProducts.length,
              itemBuilder: (context, index) {
                final product = randomProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          productIndex: index + 1,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_bag,
                            size: 50, color: Colors.blue),
                        const SizedBox(height: 10),
                        Text(
                          product['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '\$${product['price'].toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
