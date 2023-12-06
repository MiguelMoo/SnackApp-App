import 'dart:convert';
import 'package:snackapp/Models/Product.dart';
import 'package:http/http.dart' as http;

class AuthproductService {
  final String apiUrl = "http://SnackAppV2.somee.com/api/Porducto";

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        print(
            'Failed to load Products. Status code: ${response.statusCode}, Response body: ${response.body}');
        throw Exception('Failed to load Products');
      }
    } catch (e) {
      print('Error fetching Products: $e');
      return [];
    }
  }
}
