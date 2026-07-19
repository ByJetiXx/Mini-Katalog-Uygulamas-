import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String _baseUrl = "https://wantapi.com/products.php";

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    print(response.statusCode);
    print(response.body);

    if (response.statusCode != 200) {
      throw Exception("HTTP Hatası: ${response.statusCode}");
    }

    final json = jsonDecode(response.body);

    final List<dynamic> data = json["data"];

    return data.map((e) => Product.fromJson(e)).toList();
  }
}
