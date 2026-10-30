class Validadores { // Criado uma classe Validadores para o campo de login na tela de login (instâncias de class acessar sem criar um objeto)
  static String? usuario(String? v) { // static o método da classe que não é necessário criar um objeto
    final texto = v?.trim() ?? ''; // Trim remove os espaços em brancos caso digite gabriel (com espaço)
    if (texto.isEmpty) return 'Digite um nome de usuário.'; // se a variável texto estiver vazia no campo
    if (texto.length < 3) return 'Use pelo menos 3 caracteres.'; // se a variável texto tiver um comprimento menor que 3
    return null; // o parametro v o dart possui null safety para permitir nullo usa ? não encontrei erro ou seja validou então ele passou para outro campo que seria email
  } // v o texto atual do campo se a pessoa deixou o campo vazio normalmente retorna uma string vazia então esse v é basicamente um parametro digitado na tela de login do usuário

  static String? email(String? v) {
    final texto = v?.trim() ?? ''; // mesma ideia do no texto
    if (texto.isEmpty) return 'Digite seu e-mail.';
    final valido = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(texto); // validar o email o formato gabriel@exemplo
    if (!valido) return 'E-mail inválido.';
    return null;
  }

  static String? senha(String? v) {
    if (v == null || v.isEmpty) return 'Digite uma senha.';
    if (v.length < 6) return 'Use pelo menos 6 caracteres.';
    return null;
  }
}