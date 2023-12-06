// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class AddClient {
  final String apiUrl = "https://snackappv2.somee.com/api/clientes";

  Future<bool> registerClient(String nombre, String apallido, String telefono,
      String email, String contrasena) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "nombre": nombre,
          "apellido": apallido,
          "telefono": telefono,
          "correoElectronico": email,
          "contrasena": contrasena
        }),
      );

      print('Response Body: ${response.statusCode}');
      print('Response Body: ${response.contentLength}');
      print('Response Body: ${response.headers}');
      print('Response Body: ${response.request}');

      if (response.statusCode == 307) {
        // Si es una redirección, puedes obtener la nueva URL desde la cabecera 'location'
        String newUrl = response.headers['location']!;
        print(newUrl);
      }

      if (response.statusCode == 201) {
        // Registro exitoso
        return true;
      } else {
        // Registro fallido
        return false;
      }
    } catch (e) {
      // Manejo de errores
      print('Error de registro: $e');
      return false;
    }
  }
}
