import 'package:supabase_flutter/supabase_flutter.dart';

/// Autenticação real com Supabase Auth.
/// Mantém as mesmas assinaturas da versão provisória:
/// devolve null se deu certo, ou a mensagem de erro.
class AuthServico {
  static SupabaseClient get _db => Supabase.instance.client;

  // Mesmo padrão do CHECK da coluna perfis.usuario.
  static final _padraoUsuario = RegExp(r'^[a-z0-9._]{3,20}$');

  /// true se já existe uma sessão salva no aparelho (usar na TelaAbertura).
  static bool get logado => _db.auth.currentSession != null;

  static Future<String?> cadastrar({
    required String usuario,
    required String email,
    required String senha,
  }) async {
    try {
      // O banco só aceita minúsculas, números, "." e "_" (3 a 20 caracteres).
      final nome = usuario.trim().toLowerCase();
      if (!_padraoUsuario.hasMatch(nome)) {
        return 'Use de 3 a 20 caracteres: letras, números, "." ou "_".';
      }

      final disponivel = await _db.rpc(
        'usuario_disponivel',
        params: {'p_usuario': nome},
      );
      if (disponivel != true) return 'Este nome de usuário já está em uso.';

      final res = await _db.auth.signUp(
        email: email.trim().toLowerCase(),
        password: senha,
        // O gatilho handle_new_user lê isto e cria a linha em "perfis".
        data: {'usuario': nome},
      );

      // Com "Confirm email" ligado, um e-mail já cadastrado não dá erro:
      // o Supabase devolve um usuário sem identities.
      final identidades = res.user?.identities;
      if (res.user != null && identidades != null && identidades.isEmpty) {
        return 'Este e-mail já tem uma conta.';
      }
      return null;
    } on AuthException catch (e) {
      return _traduzir(e);
    } catch (_) {
      return 'Não foi possível conectar. Verifique sua internet.';
    }
  }

  static Future<String?> entrar({
    required String email,
    required String senha,
  }) async {
    try {
      await _db.auth.signInWithPassword(
        email: email.trim().toLowerCase(),
        password: senha,
      );
      return null;
    } on AuthException catch (e) {
      return _traduzir(e);
    } catch (_) {
      return 'Não foi possível conectar. Verifique sua internet.';
    }
  }

  static Future<void> sair() => _db.auth.signOut();

  static String _traduzir(AuthException e) {
    switch (e.code) {
      case 'invalid_credentials':
        return 'E-mail ou senha incorretos.';
      case 'email_not_confirmed':
        return 'Confirme seu e-mail antes de entrar.';
      case 'user_already_exists':
      case 'email_exists':
        return 'Este e-mail já tem uma conta.';
      case 'weak_password':
        return 'Senha fraca. Use 6 ou mais caracteres, com maiúscula, minúscula, número e símbolo.';
      case 'over_request_rate_limit':
      case 'over_email_send_rate_limit':
        return 'Muitas tentativas. Aguarde um pouco e tente de novo.';
      default:
        return 'Algo deu errado (${e.message}).';
    }
  }
}