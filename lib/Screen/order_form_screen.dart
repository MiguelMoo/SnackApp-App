import 'package:flutter/material.dart';
import '../Services/createOrden.dart';

class OrderFormScreen extends StatefulWidget {
  final int idcliente;
  final String nombre;
  final int idvendedor;
  final int idproducto;

  const OrderFormScreen({
    required this.nombre,
    required this.idcliente,
    required this.idvendedor,
    required this.idproducto,
  });

  @override
  _OrderFormScreenState createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  TextEditingController direccionEnvioController = TextEditingController();
  TextEditingController cantidadController = TextEditingController();

  String? selectedDetail;
  String? selectedMetodo;

  List<String> predefinedDetails = ['Efectivo'];
  List<String> predefinedMetodo = ['Delivery', 'Pick Up'];
  bool resultado = false;
  String successMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orden Formulario'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: TextField(
                controller: direccionEnvioController,
                decoration: InputDecoration(labelText: 'Dirección de Envío'),
              ),
            ),
            DropdownButtonFormField<String>(
              value: selectedDetail,
              onChanged: (String? value) {
                setState(() {
                  selectedDetail = value;
                });
              },
              decoration: InputDecoration(labelText: 'Detalles de Pago'),
              items: predefinedDetails.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            DropdownButtonFormField<String>(
              value: selectedMetodo,
              onChanged: (String? value) {
                setState(() {
                  selectedMetodo = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Detalles de Entrega'),
              items: predefinedMetodo.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: TextField(
                controller: cantidadController,
                decoration: InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                this.resultado =
                    await makeOrder(widget.idcliente, selectedMetodo, selectedDetail);
                if (resultado != null && resultado) {
                  // Hacer algo si la orden se creó correctamente
                }
              },
              style: getButtonStyle(),
              child: Text(
                'Añadir al carrito',
                style: getButtonTextStyle(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              successMessage,
              style: TextStyle(
                color: resultado != null && resultado ? Colors.green : Colors.red,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    direccionEnvioController.dispose();
    cantidadController.dispose();
    super.dispose();
  }

  Future<bool> makeOrder(int idcliente, String? metodo, String? detallesPago) async {
    if (direccionEnvioController.text.isEmpty ||
        cantidadController.text.isEmpty ||
        metodo == null ||
        detallesPago == null) {
      setState(() {
        successMessage = 'Por favor, complete todos los campos.';
      });
      return false;
    }

    CreateOrden carrito = CreateOrden();
    var a = await carrito.createCarrito(idcliente, metodo);
    if (a) {
      setState(() {
        successMessage = 'La orden se ha añadido al carrito exitosamente.';
      });
      print("se creó correctamente la orden");
      return true;
    } else {
      setState(() {
        successMessage = 'Hubo un problema al crear la orden. Inténtalo de nuevo.';
      });
      return false;
    }
  }

  TextStyle getButtonTextStyle() {
    return TextStyle(
      color: resultado != null && resultado ? Colors.white : Colors.black,
    );
  }

  ButtonStyle getButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        resultado != null && resultado ? Colors.green : Colors.red,
      ),
    );
  }
}
