class Product {
  final int ID;
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

  Product(
      {required this.ID,
      required this.Categoria,
      required this.claveProducto,
      required this.NombreProducto,
      required this.Descripcion,
      required this.Tamano,
      required this.Sabor,
      required this.Precio,
      required this.Disponibilidad,
      required this.PromocionesDescuentos,
      required this.Id_puesto});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      ID: json['id'],
      Categoria: json['categoria'],
      claveProducto: json['claveProducto'],
      NombreProducto: json['nombreProducto'],
      Descripcion: json['descripcion'],
      Tamano: json['tamano'],
      Sabor: json['sabor'],
      Precio: json['precio'].toDouble(),
      Disponibilidad: json['disponibilidad'],
      PromocionesDescuentos: json['promocionesDescuentos'],
      Id_puesto: json['idPuesto'],
    );
  }
}
