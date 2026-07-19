import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../widgets/product_card.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();

  List<Product> products = [];
  List<Product> filteredProducts = [];
  List<Product> cart = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final result = await apiService.getProducts();

      setState(() {
        products = result;
        filteredProducts = result;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void search(String value) {
    setState(() {
      filteredProducts = products.where((product) {
        return product.name.toLowerCase().contains(value.toLowerCase()) ||
            product.tagline.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }

  void addToCart(Product product) {
    setState(() {
      cart.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product.name} sepete eklendi."),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mini Katalog"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Badge(
              label: Text(cart.length.toString()),
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartPage(cart: cart)),
              );

              setState(() {});
            },
          ),
        ],
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Image.network(
                  "https://wantapi.com/assets/banner.png",
                  width: double.infinity,
                  height: 100,
                  fit: BoxFit.cover,
                ),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    onChanged: search,
                    decoration: InputDecoration(
                      hintText: "Ürün Ara...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),

                    itemCount: filteredProducts.length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: .45,
                        ),

                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: filteredProducts[index],
                        onAddToCart: addToCart,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
