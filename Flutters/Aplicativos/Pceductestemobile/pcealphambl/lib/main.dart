import 'package:flutter/material.dart';
import 'core/cores.dart';
import 'core/tema.dart';
import 'telas/tela_abertura.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );
  runApp(const PcEducApp());
}

class PcEducApp extends StatelessWidget {
  const PcEducApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Tema.modoEscuro,
      builder: (context, isDark, _) {
        return MaterialApp(
          title: 'PC educ',
          debugShowCheckedModeBanner: false,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            useMaterial3: true, 
            colorSchemeSeed: Cores.azulFundo,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            useMaterial3: true, 
            colorSchemeSeed: Cores.azulFundo,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212),
          ),
          home: const TelaAbertura(),
        );
      }
    );
  }
}