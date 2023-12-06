class Client {
  final int idCliente;  // Corregir el nombre del campo
  final String nombre;
  final String apellido;
  final String telfono;
  final String correoElectronico;
  final String contrasena;

  Client({
    // ignore: non_constant_identifier_names
    required this.idCliente,  // Corregir el nombre del parámetro
    required this.nombre,
    required this.apellido,
    required this.telfono,
    required this.correoElectronico,
    required this.contrasena,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      idCliente: json['idCliente'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      telfono: json['telefono'],
      correoElectronico: json['correoElectronico'],
      contrasena: json['contrasena'],
    );
  }
}
