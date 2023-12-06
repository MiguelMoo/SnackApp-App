import 'package:flutter/material.dart';
import '../Validation/ValidarPassword.dart';
import '../services/AddClientService.dart';
import '../services/ClientServices.dart';
import 'login_view.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegistrationScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registro'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(
                    labelText: 'Apellido',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _correoController,
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _telefonoController,
                  decoration: const InputDecoration(
                    labelText: 'Telefono',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    // validacion login con api
                    if (_nombreController.text.isEmpty ||
                        _apellidoController.text.isEmpty ||
                        _correoController.text.isEmpty ||
                        _telefonoController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      // Muestra un SnackBar con un mensaje de error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Por favor, completa todos los campos.'),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        ),
                      );
                      return; // Sale de la función si hay campos vacíos
                    } // Lógica para registrar al vendedor

                    Validar validar = Validar();

                    // Validación de la contraseña (puedes personalizar los criterios)
                    if (_passwordController.text.length < 8) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'La contraseña debe tener al menos 8 caracteres.'),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Validación del formato del número de teléfono (puedes personalizar según tus necesidades)
                    if (!validar.isValidPhoneNumber(_telefonoController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Por favor, ingresa un número de teléfono válido.'),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Validación de formato de correo electrónico
                    if (!validar.isValidEmail(_correoController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Por favor, ingresa un correo electrónico válido.'),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    AuthClientService authClientService = AuthClientService();
                    bool isEmailUnique = await authClientService
                        .isEmailUnique(_correoController.text);

                    if (!isEmailUnique) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Este correo electrónico ya está registrado.'),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    String nombre = _nombreController.text;
                    String apellido = _apellidoController.text;
                    String telefono = _telefonoController.text;
                    String correo = _correoController.text;
                    String password = _passwordController.text;

                    // Crea una instancia del servicio de autenticación
                    AddClient addClient = AddClient();

                    // Realiza el registro
                    bool isRegistered = await addClient.registerClient(
                        nombre, apellido, telefono, correo, password);
                    print(isRegistered);
                    if (isRegistered) {
                      // Muestra un SnackBar con mensaje de éxito
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('¡Usuario registrado correctamente!'),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Redirige después de un retardo
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      });
                    } else {
                      // Muestra un SnackBar con mensaje de error
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Hubo un error al registrar la cuenta. Por favor, inténtelo de nuevo.'),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.fixed,
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ));
  }
}
