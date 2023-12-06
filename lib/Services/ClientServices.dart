// ignore_for_file: avoid_web_libraries_in_flutter, avoid_print
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:snackapp/models/AuthResult.dart';
import 'package:snackapp/models/Client.dart';

class AuthClientService {
  final String apiUrl = "http://SnackAppV2.somee.com/api/Clientes";

  Future<List<Client>> getAllClients() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Client.fromJson(json)).toList();
      } else {
        print(
            'Failed to load clients. Status code: ${response.statusCode}, Response body: ${response.body}');
        throw Exception('Failed to load clients');
      }
    } catch (e) {
      print('Error fetching clients: $e');
      return [];
    }
  }

  Future<AuthResult> authenticateClient(
      String clientEmail, String password) async {
    try {
      // Check if clientEmail and password are not empty
      if (clientEmail.isEmpty || password.isEmpty) {
        return AuthResult(isAuthenticated: false, clientName: '', idClinete: 0);
      }

      // Get the list of clients
      List<Client> clients = await getAllClients();

      // Find the client with the provided email
      Client matchedClient = clients
          .firstWhere((client) => client.correoElectronico == clientEmail);

      // Check if the client's password matches
      bool isMatched = matchedClient.contrasena == password;

      // Return AuthResult indicating authentication result and clientName
      return AuthResult(
          isAuthenticated: isMatched,
          clientName: matchedClient.nombre,
          idClinete: matchedClient.idCliente);
    } catch (e) {
      // Error handling
      print('Authentication error: $e');
      return AuthResult(isAuthenticated: false, clientName: '', idClinete: 0);
    }
  }

  Future<bool> isEmailUnique(String email) async {
    try {
      // Obtener la lista de clientes
      List<Client> clients = await getAllClients();

      // Verificar si ya existe un cliente con el correo electrónico proporcionado
      bool isUnique = clients.every(
        (client) => client.correoElectronico != email,
      );

      // Devolver true si el correo es único
      return isUnique;
    } catch (e) {
      // Manejar errores según tus necesidades
      print('Error verificando la unicidad del correo electrónico: $e');
      return false;
    }
  }
}
