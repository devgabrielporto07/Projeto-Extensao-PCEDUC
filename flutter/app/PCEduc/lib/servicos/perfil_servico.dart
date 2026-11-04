import 'package:supabase_flutter/supabase_flutter.dart';

/// Dados do perfil de quem está logado (tabela "perfis").
class Perfil {
  const Perfil({
    this.nome,
    this.usuario,
    this.fotoUrl,
    this.email,
    this.nomeSugerido,
    this.xp = 0,
    this.sequenciaDias = 0,
  });

  final String? nome;
  final String? usuario;
  final String? fotoUrl;
  final String? email; // vem do login (auth), não da tabela perfis

  /// Nome que o Google informou (só para pré-preencher; o aluno confirma ou troca).
  final String? nomeSugerido;
  final int xp;
  final int sequenciaDias;

  factory Perfil.deMapa(Map<String, dynamic> m, {String? email, String? nomeSugerido}) => Perfil(
        nome: m['nome'] as String?,
        usuario: m['usuario'] as String?,
        fotoUrl: m['foto_url'] as String?,
        email: email,
        nomeSugerido: nomeSugerido,
        xp: (m['xp'] as num?)?.toInt() ?? 0,
        sequenciaDias: (m['sequencia_dias'] as num?)?.toInt() ?? 0,
      );
}

class PerfilServico {
  static SupabaseClient get _db => Supabase.instance.client;

  /// Lê o perfil de quem está logado. Devolve null se não achar ou se der erro.
  static Future<Perfil?> carregar() async {
    try {
      final uid = _db.auth.currentUser?.id;
      if (uid == null) return null;

      final dados = await _db
          .from('perfis')
          .select('nome, usuario, foto_url, xp, sequencia_dias')
          .eq('id', uid)
          .maybeSingle();

      if (dados == null) return null;
      final meta = _db.auth.currentUser?.userMetadata;
      var sugerido = ((meta?['full_name'] ?? meta?['name']) as String?)?.trim();
      if (sugerido != null && sugerido.length > 50) sugerido = sugerido.substring(0, 50);
      if (sugerido != null && sugerido.length < 2) sugerido = null;

      return Perfil.deMapa(
        dados,
        email: _db.auth.currentUser?.email,
        nomeSugerido: sugerido,
      );
    } catch (_) {
      return null;
    }
  }

  /// Salva o perfil pela função atualizar_perfil do banco.
  /// Devolve null se deu certo, ou a mensagem de erro para mostrar na tela.
  ///
  /// ATENÇÃO: a função grava nome, @usuario e foto de uma vez, e valor nulo APAGA
  /// o campo. Por isso a foto atual precisa ser reenviada em [fotoUrl].
  static Future<String?> atualizar({
    required String nome,
    required String usuario,
    String? fotoUrl,
  }) async {
    try {
      await _db.rpc('atualizar_perfil', params: {
        'p_nome': nome,
        'p_usuario': usuario,
        'p_foto_url': fotoUrl,
      });
      return null;
    } on PostgrestException catch (e) {
      // A função do banco já devolve a mensagem em português no campo "hint".
      final dica = e.hint;
      if (dica != null && dica.isNotEmpty) return dica;
      return 'Não foi possível salvar o perfil (${e.message}).';
    } catch (_) {
      return 'Não foi possível conectar. Verifique sua internet.';
    }
  }
}