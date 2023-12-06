import 'package:flutter/material.dart';

import '../Models/Product.dart';
import '../Services/productService.dart';
import 'product_details_screen.dart';

class ProductScreen extends StatefulWidget {
  final String clientName;
  final int idCliente;

  const ProductScreen(
      {Key? key, required this.clientName, required this.idCliente})
      : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final AuthproductService productService = AuthproductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: FutureBuilder<List<Product>>(
        future: productService.getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Product>? products = snapshot.data;

            return ListView.builder(
              itemCount: products?.length ?? 0,
              itemBuilder: (context, index) {
                Product product = products![index];
                return ProductTile(
                  Categoria: product.Categoria,
                  claveProducto: product.claveProducto,
                  NombreProducto: product.NombreProducto,
                  Descripcion: product.Descripcion,
                  Tamano: product.Tamano,
                  Precio: product.Precio,
                  Sabor: product.Sabor,
                  Disponibilidad: product.Disponibilidad,
                  PromocionesDescuentos: product.PromocionesDescuentos,
                  Id_puesto: product.Id_puesto,
                  onTap: () {
                    _navigateToProductDetails(
                        context, product, widget.idCliente);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void _navigateToProductDetails(
      BuildContext context, Product product, int idCliente) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          ID: product.ID,
          idclinete: idCliente,
          Categoria: product.Categoria,
          claveProducto: product.claveProducto,
          Tamano: product.Tamano,
          Descripcion: product.Descripcion,
          Sabor: product.Sabor,
          Precio: product.Precio,
          Disponibilidad: product.Disponibilidad,
          PromocionesDescuentos: product.PromocionesDescuentos,
          Id_puesto: product.Id_puesto,
          nombre: product.NombreProducto,
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final String Categoria;
  final String claveProducto;
  final String NombreProducto;
  final String? Descripcion;
  final String Tamano;
  final String? Sabor;
  final double Precio;
  final int Disponibilidad;
  final String? PromocionesDescuentos;
  final int Id_puesto;
  final VoidCallback onTap;

  ProductTile({
    required this.onTap,
    this.Descripcion,
    required this.Tamano,
    this.Sabor,
    required this.Precio,
    required this.Disponibilidad,
    this.PromocionesDescuentos,
    required this.Id_puesto,
    required this.Categoria,
    required this.claveProducto,
    required this.NombreProducto,
  });

  @override
  Widget build(BuildContext context) {
    print("holaaaaa");

    return ListTile(
      title: Text(NombreProducto),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Category: $Categoria"),
          Text("Size: $Tamano"),
          Text("Price: $Precio"),
        ],
      ),
      onTap: onTap,
    );
  }
}
