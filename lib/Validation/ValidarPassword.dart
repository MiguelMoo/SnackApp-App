class Validar {
  bool isValidPhoneNumber(String phoneNumber) {
    // Puedes personalizar esta validación según tus necesidades
    final phoneRegex = RegExp(r'^\d{10}$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  bool isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9.!#$%&\*+/=?^{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    return emailRegex.hasMatch(email);
  }
}
