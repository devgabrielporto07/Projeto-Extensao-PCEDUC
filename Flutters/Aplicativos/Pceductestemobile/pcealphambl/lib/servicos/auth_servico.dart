/// Serviço de autenticação PROVISÓRIO.
/// Guarda as contas só na memória (somem quando o app fecha) para testarmos
/// o fluxo. Depois será trocado por um servidor de verdade.
class AuthServico {
  // e-mail -> senha. SÓ PARA TESTE: num servidor real a senha nunca é guardada assim.
  static final Map<String, String> _contas = {};

  /// Devolve null se deu certo, ou a mensagem de erro.
  static Future<String?> cadastrar({
    required String usuario, // será guardado quando houver um banco de verdade
    required String email,
    required String senha,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // simula a espera da internet
    final chave = email.trim().toLowerCase();
    if (_contas.containsKey(chave)) return 'Este e-mail já tem uma conta.';
    _contas[chave] = senha;
    return null;
  }

  /// Devolve null se deu certo, ou a mensagem de erro.
  static Future<String?> entrar({
    required String email,
    required String senha,               //deu preguiça fiz no Claude
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final chave = email.trim().toLowerCase();
    if (_contas[chave] != senha) return 'E-mail ou senha incorretos.';
    return null;
  }
}