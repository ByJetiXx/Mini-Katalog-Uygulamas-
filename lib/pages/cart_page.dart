import 'package:flutter/material.dart';
import '../models/product.dart';

class CartPage extends StatefulWidget {
  final List<Product> cart;

  const CartPage({super.key, required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double get totalPrice {
    double total = 0;

    for (var product in widget.cart) {
      final price = double.tryParse(product.price.replaceAll("\$", "")) ?? 0;

      total += price;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepetim"),

        centerTitle: true,

        actions: [
          if (widget.cart.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),

              onPressed: () {
                setState(() {
                  widget.cart.clear();
                });
              },
            ),
        ],
      ),

      body: widget.cart.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 15),

                  Text(
                    "Sepetiniz boş",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,

                    itemBuilder: (context, index) {
                      final product = widget.cart[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),

                        child: ListTile(
                          leading: Image.network(
                            product.image,
                            width: 60,
                            height: 60,
                          ),

                          title: Text(product.name),

                          subtitle: Text(
                            "${product.price} ${product.currency}",
                          ),

                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),

                            onPressed: () {
                              setState(() {
                                widget.cart.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(color: Colors.grey.shade100),

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          const Text(
                            "Toplam Ürün",

                            style: TextStyle(fontSize: 18),
                          ),

                          Text(widget.cart.length.toString()),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          const Text(
                            "Toplam Tutar",

                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "\$${totalPrice.toStringAsFixed(2)}",

                            style: const TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,

                        child: FilledButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Sipariş oluşturuldu (Simülasyon)",
                                ),
                              ),
                            );
                          },

                          child: const Text("Siparişi Tamamla"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
