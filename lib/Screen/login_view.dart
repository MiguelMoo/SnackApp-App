import 'package:flutter/material.dart';
import '../models/AuthResult.dart';
import '../services/ClientServices.dart';
import 'home_view.dart';
import 'regritation_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginScreen extends StatelessWidget {
  // Controladores para los campos de texto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/logo1.png',
              height: 200,
              width: 400,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      // Obtener el texto ingresado por el usuario
                      String email = emailController.text;
                      String password = passwordController.text;

                      AuthClientService authService = AuthClientService();
                      AuthResult authResult =
                          await authService.authenticateClient(email, password);

                      print(authResult.isAuthenticated);

                      if (authResult.isAuthenticated) {
                        // Solicitar permisos de ubicación
                        var status = await Permission.location.request();

                        // Verificar si el usuario concedió los permisos
                        if (!status.isGranted) {
                          // Mostrar mensaje si los permisos de ubicación no fueron concedidos
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:
                                    const Text('Permisos de ubicación denegados'),
                                content: const Text(
                                    'Por favor, concede los permisos de ubicación para continuar.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }

                        // Verificar si la ubicación está activada
                        var isLocationEnabled =
                            await Geolocator.isLocationServiceEnabled();
                        print(
                            "La ubicación está activada: ${isLocationEnabled}");

                        if (isLocationEnabled) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                clientName: authResult.clientName,
                                idCliente: authResult.idClinete,
                              ),
                            ),
                          );
                        } else {
                          // Muestra un diálogo para solicitar activar la ubicación
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Ubicación no activada'),
                                content: const Text(
                                    'Por favor, activa la ubicación para continuar.'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);

                                      // Solicitar activación de la ubicación
                                      await Geolocator.openLocationSettings();
                                    },
                                    child: const Text('Activar Ubicación'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        // Muestra un mensaje de error si la autenticación falla
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:
                                  const Text('Error de inicio de sesión'),
                              content: const Text(
                                  'Credenciales incorrectas. Por favor, inténtelo de nuevo.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationScreen()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '¿No tienes una cuenta? Regístrate aquí',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
