import 'package:flutter/material.dart';

import 'order_form_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String nombre;
  final String Categoria;
  final String claveProducto;
  final String? Descripcion;
  final String Tamano;
  final String? Sabor;
  final double Precio;
  final int Disponibilidad;
  final int ID;
  final String? PromocionesDescuentos;
  final int Id_puesto;
  final int idclinete;

  const ProductDetailsScreen({
    required this.nombre,
    required this.Categoria,
    required this.claveProducto,
    this.Descripcion,
    required this.Tamano,
    this.Sabor,
    required this.Precio,
    required this.Disponibilidad,
    this.PromocionesDescuentos,
    required this.Id_puesto,
    required this.ID,
    required this.idclinete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nombre,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Category: $Categoria',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Product Key: $claveProducto',
              style: const TextStyle(fontSize: 16),
            ),
            if (Descripcion != null)
              Text(
                'Description: $Descripcion',
                style: const TextStyle(fontSize: 16),
              ),
            Text(
              'Size: $Tamano',
              style: const TextStyle(fontSize: 16),
            ),
            if (Sabor != null)
              Text(
                'Flavor: $Sabor',
                style: const TextStyle(fontSize: 16),
              ),
            Text(
              'Price: $Precio',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Availability: $Disponibilidad',
              style: const TextStyle(fontSize: 16),
            ),
            if (PromocionesDescuentos != null)
              Text(
                'Discounts: $PromocionesDescuentos',
                style: const TextStyle(fontSize: 16),
              ),
            Text(
              'Availability: $idclinete',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _navigateToMakeOrder(context, nombre, idclinete, Id_puesto, ID);
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToMakeOrder(
      BuildContext context, String nombre, int iddliente, int idvendedor, int idproducto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OrderFormScreen(nombre: nombre, idcliente: idclinete, idvendedor: idvendedor, idproducto: idproducto,),
      ),
    );
  }
}
