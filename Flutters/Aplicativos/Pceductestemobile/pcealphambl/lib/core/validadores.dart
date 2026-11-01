class Validadores {
  static String? usuario(String? v) {
    final texto = v?.trim() ?? '';
    if (texto.isEmpty) return 'Digite um nome de usuário.';
    if (texto.length < 3) return 'Use pelo menos 3 caracteres.';
    return null;
  }

  static String? email(String? v) {
    final texto = v?.trim() ?? '';
    if (texto.isEmpty) return 'Digite seu e-mail.';
    final valido = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(texto);
    if (!valido) return 'E-mail inválido.';
    return null;
  }

  static String? senha(String? v) {
    if (v == null || v.isEmpty) return 'Digite uma senha.';
    if (v.length < 8) return 'Use pelo menos 8 caracteres.';
    return null;
  }
}