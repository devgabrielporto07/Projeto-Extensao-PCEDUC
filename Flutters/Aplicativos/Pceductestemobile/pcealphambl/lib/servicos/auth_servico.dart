class AuthServico {
  // Banco de dados falso na memória (apaga ao fechar a app)
  static final Map<String, String> _contas = {};

  static Future<String?> cadastrar({
    required String usuario,
    required String email,
    required String senha,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simula tempo de carregamento
    
    if (_contas.containsKey(email)) {
      return 'Este e-mail já está cadastrado.';
    }
    
    _contas[email] = senha;
    return null; // Sucesso
  }

  static Future<String?> entrar({
    required String email,
    required String senha,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simula tempo de carregamento
    
    if (!_contas.containsKey(email) || _contas[email] != senha) {
      return 'E-mail ou senha inválidos.';
    }
    
    return null; // Sucesso
  }

  // NOVO MÉTODO DE SAIR (Resolve o erro do tela_menu.dart)
  static Future<void> sair() async {
    // Como é provisório, apenas simulamos um pequeno atraso. 
    // A TelaMenu já se encarrega de o mandar para a TelaLogin!
    await Future.delayed(const Duration(milliseconds: 300));
  }
}