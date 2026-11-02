class Validadores {
  static String? usuario(String? v) {
    final texto = (v?.trim() ?? '').toLowerCase();
    if (texto.isEmpty) return 'Digite um nome de usuário.';
    if (!RegExp(r'^[a-z0-9._]{3,20}$').hasMatch(texto)) {
      return 'Use 3 a 20 caracteres: letras, números, "." ou "_".';
    }
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
    if (v.length < 6) return 'Use pelo menos 6 caracteres.';
    if (!RegExp(r'[a-z]').hasMatch(v)) return 'Inclua uma letra minúscula.';
    if (!RegExp(r'[A-Z]').hasMatch(v)) return 'Inclua uma letra maiúscula.';
    if (!RegExp(r'[0-9]').hasMatch(v)) return 'Inclua um número.';
    if (!RegExp(r'''[!@#$%^&*()_+\-=\[\]{};':"\\|<>?,./`~]''').hasMatch(v)) {
      return 'Inclua um símbolo, como ! @ # \$ %.';
    }
    return null;
  }
}