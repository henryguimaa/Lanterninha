import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _modoEscuro = true;

  void _alternarTema() {
    setState(() {
      _modoEscuro = !_modoEscuro;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lanterna Inteligente',
      themeMode: _modoEscuro ? ThemeMode.dark : ThemeMode.light,
      theme: AppTemas.temaClaro,
      darkTheme: AppTemas.temaEscuro,
      home: LanternaScreen(
        modoEscuro: _modoEscuro,
        alternarTema: _alternarTema,
      ),
    );
  }
}

class AppCores {
  static const laranja = Color(0xFFFF6D00);
  static const laranjaClaro = Color(0xFFFF9E40);
  static const laranjaEscuro = Color(0xFFD95300);

  static const preto = Color(0xFF080808);
  static const pretoSuave = Color(0xFF101010);
  static const cinzaEscuro = Color(0xFF1A1A1A);
  static const cinzaMedio = Color(0xFF2B2B2B);
  static const cinzaClaro = Color(0xFFB8B8B8);
  static const cinzaTexto = Color(0xFF777777);

  static const branco = Color(0xFFF5F5F5);

  static const fundoClaro = Color(0xFFF1F2F4);
  static const cardClaro = Color(0xFFFFFFFF);
  static const cinzaClaroTema = Color(0xFFD9DBDE);
  static const textoClaro = Color(0xFF202124);
  static const textoSecundarioClaro = Color(0xFF707070);
}

class AppTemas {
  static ThemeData temaEscuro = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppCores.preto,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppCores.laranja,
      brightness: Brightness.dark,
    ),
  );

  static ThemeData temaClaro = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppCores.fundoClaro,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppCores.laranja,
      brightness: Brightness.light,
    ),
  );
}

class LanternaScreen extends StatefulWidget {
  final bool modoEscuro;
  final VoidCallback alternarTema;

  const LanternaScreen({
    super.key,
    required this.modoEscuro,
    required this.alternarTema,
  });

  @override
  State<LanternaScreen> createState() => _LanternaScreenState();
}

class _LanternaScreenState extends State<LanternaScreen> {
  bool _lanternaLigada = false;
  bool _modoAutomatico = false;

  void _alternarLanterna() {
    setState(() {
      _lanternaLigada = !_lanternaLigada;
    });

    _mostrarMensagem(
      _lanternaLigada
          ? 'Lanterna ligada'
          : 'Lanterna desligada',
      _lanternaLigada
          ? AppCores.laranja
          : widget.modoEscuro
              ? AppCores.cinzaMedio
              : AppCores.cinzaClaroTema,
    );
  }

  void _alternarModoAutomatico(bool valor) {
    setState(() {
      _modoAutomatico = valor;
    });

    _mostrarMensagem(
      valor
          ? 'Modo automático ativado'
          : 'Modo automático desativado',
      valor
          ? AppCores.laranja
          : widget.modoEscuro
              ? AppCores.cinzaMedio
              : AppCores.cinzaClaroTema,
    );
  }

  void _mostrarMensagem(String mensagem, Color cor) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mensagem,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: cor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool escuro = widget.modoEscuro;

    final Color fundo = escuro
        ? AppCores.preto
        : AppCores.fundoClaro;

    final Color card = escuro
        ? AppCores.cinzaEscuro
        : AppCores.cardClaro;

    final Color cardSecundario = escuro
        ? AppCores.cinzaMedio
        : AppCores.cinzaClaroTema;

    final Color textoPrincipal = escuro
        ? AppCores.branco
        : AppCores.textoClaro;

    final Color textoSecundario = escuro
        ? AppCores.cinzaTexto
        : AppCores.textoSecundarioClaro;

    return Scaffold(
      backgroundColor: fundo,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                22,
                18,
                22,
                14,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AnimatedContainer(
                        duration:
                            const Duration(milliseconds: 300),
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: _lanternaLigada
                              ? AppCores.laranja
                                  .withOpacity(0.12)
                              : card,
                          borderRadius:
                              BorderRadius.circular(14),
                          border: Border.all(
                            color: _lanternaLigada
                                ? AppCores.laranja
                                : cardSecundario,
                          ),
                        ),
                        child: Icon(
                          Icons.flashlight_on,
                          color: _lanternaLigada
                              ? AppCores.laranja
                              : textoSecundario,
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LANTERNA',
                            style: TextStyle(
                              color: textoPrincipal,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'SMART CONTROL',
                            style: TextStyle(
                              color: textoSecundario,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: widget.alternarTema,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: card,
                            borderRadius:
                                BorderRadius.circular(13),
                            border: Border.all(
                              color: cardSecundario,
                            ),
                          ),
                          child: Icon(
                            escuro
                                ? Icons.light_mode
                                : Icons.dark_mode,
                            color: AppCores.laranja,
                            size: 21,
                          ),
                        ),
                      ),
                      const SizedBox(width: 9),
                      AnimatedContainer(
                        duration:
                            const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _lanternaLigada
                              ? AppCores.laranja
                                  .withOpacity(0.10)
                              : card,
                          borderRadius:
                              BorderRadius.circular(20),
                          border: Border.all(
                            color: _lanternaLigada
                                ? AppCores.laranja
                                : cardSecundario,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: _lanternaLigada
                                    ? AppCores.laranja
                                    : textoSecundario,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 7),
                            Text(
                              _lanternaLigada
                                  ? 'ON'
                                  : 'OFF',
                              style: TextStyle(
                                color: _lanternaLigada
                                    ? AppCores.laranja
                                    : textoSecundario,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22),
              child: AnimatedContainer(
                duration:
                    const Duration(milliseconds: 350),
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: _modoAutomatico
                      ? AppCores.laranja.withOpacity(0.07)
                      : card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: _modoAutomatico
                        ? AppCores.laranja.withOpacity(0.65)
                        : cardSecundario,
                  ),
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration:
                          const Duration(milliseconds: 300),
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _modoAutomatico
                            ? AppCores.laranja
                                .withOpacity(0.14)
                            : cardSecundario,
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.auto_mode,
                        color: _modoAutomatico
                            ? AppCores.laranja
                            : textoSecundario,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Modo Automático',
                            style: TextStyle(
                              color: textoPrincipal,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _modoAutomatico
                                ? 'Controle automático ativado'
                                : 'Controle inteligente da iluminação',
                            style: TextStyle(
                              color: textoSecundario,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _modoAutomatico,
                      onChanged:
                          _alternarModoAutomatico,
                      activeColor: AppCores.laranja,
                      activeTrackColor:
                          AppCores.laranjaEscuro,
                      inactiveThumbColor:
                          escuro
                              ? AppCores.cinzaClaro
                              : AppCores.laranja,
                      inactiveTrackColor:
                          cardSecundario,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  Expanded(
                    child: _PainelInfo(
                      titulo: 'STATUS',
                      valor: _lanternaLigada
                          ? 'ATIVA'
                          : 'INATIVA',
                      icone: Icons.power,
                      destaque: _lanternaLigada,
                      card: card,
                      borda: cardSecundario,
                      textoPrincipal: textoPrincipal,
                      textoSecundario: textoSecundario,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _PainelInfo(
                      titulo: 'MODO',
                      valor: _modoAutomatico
                          ? 'AUTO'
                          : 'MANUAL',
                      icone: Icons.tune,
                      destaque: _modoAutomatico,
                      card: card,
                      borda: cardSecundario,
                      textoPrincipal: textoPrincipal,
                      textoSecundario: textoSecundario,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _PainelInfo(
                      titulo: 'LUZ',
                      valor: _lanternaLigada
                          ? '100%'
                          : '0%',
                      icone: Icons.wb_sunny_outlined,
                      destaque: _lanternaLigada,
                      card: card,
                      borda: cardSecundario,
                      textoPrincipal: textoPrincipal,
                      textoSecundario: textoSecundario,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedContainer(
                      duration:
                          const Duration(milliseconds: 700),
                      curve: Curves.easeInOut,
                      width:
                          _lanternaLigada ? 330 : 170,
                      height:
                          _lanternaLigada ? 330 : 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _lanternaLigada
                            ? AppCores.laranja
                                .withOpacity(0.025)
                            : Colors.transparent,
                        boxShadow: _lanternaLigada
                            ? [
                                BoxShadow(
                                  color: AppCores.laranja
                                      .withOpacity(0.12),
                                  blurRadius: 120,
                                  spreadRadius: 35,
                                ),
                              ]
                            : [],
                      ),
                    ),
                    AnimatedContainer(
                      duration:
                          const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      width:
                          _lanternaLigada ? 215 : 150,
                      height:
                          _lanternaLigada ? 215 : 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _lanternaLigada
                            ? AppCores.laranja
                                .withOpacity(0.08)
                            : card,
                        border: Border.all(
                          color: _lanternaLigada
                              ? AppCores.laranja
                              : cardSecundario,
                          width: 2,
                        ),
                        boxShadow: _lanternaLigada
                            ? [
                                BoxShadow(
                                  color: AppCores.laranja
                                      .withOpacity(0.40),
                                  blurRadius: 55,
                                  spreadRadius: 10,
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(
                                    escuro ? 0.5 : 0.08,
                                  ),
                                  blurRadius: 20,
                                  offset:
                                      const Offset(0, 8),
                                ),
                              ],
                      ),
                      child: AnimatedScale(
                        duration:
                            const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        scale:
                            _lanternaLigada ? 1.15 : 0.88,
                        child: Icon(
                          _lanternaLigada
                              ? Icons.flashlight_on
                              : Icons.flashlight_off,
                          color: _lanternaLigada
                              ? AppCores.laranja
                              : textoSecundario,
                          size: 76,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            AnimatedSwitcher(
              duration:
                  const Duration(milliseconds: 300),
              child: Column(
                key: ValueKey(_lanternaLigada),
                children: [
                  Text(
                    _lanternaLigada
                        ? 'ILUMINAÇÃO ATIVADA'
                        : 'ILUMINAÇÃO DESATIVADA',
                    style: TextStyle(
                      color: _lanternaLigada
                          ? AppCores.laranja
                          : textoPrincipal,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _lanternaLigada
                        ? 'Sistema operando normalmente'
                        : 'Toque no botão para ligar',
                    style: TextStyle(
                      color: textoSecundario,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 17),

            GestureDetector(
              onTap: _alternarLanterna,
              child: AnimatedContainer(
                duration:
                    const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _lanternaLigada
                      ? AppCores.laranja
                      : card,
                  border: Border.all(
                    color: _lanternaLigada
                        ? AppCores.laranjaClaro
                        : cardSecundario,
                    width: 2,
                  ),
                  boxShadow: _lanternaLigada
                      ? [
                          BoxShadow(
                            color: AppCores.laranja
                                .withOpacity(0.50),
                            blurRadius: 38,
                            spreadRadius: 6,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              escuro ? 0.55 : 0.10,
                            ),
                            blurRadius: 18,
                            offset:
                                const Offset(0, 7),
                          ),
                        ],
                ),
                child: AnimatedScale(
                  duration:
                      const Duration(milliseconds: 200),
                  scale:
                      _lanternaLigada ? 1.0 : 0.90,
                  child: Icon(
                    Icons.power_settings_new,
                    color: _lanternaLigada
                        ? Colors.white
                        : textoPrincipal,
                    size: 44,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _PainelInfo extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icone;
  final bool destaque;
  final Color card;
  final Color borda;
  final Color textoPrincipal;
  final Color textoSecundario;

  const _PainelInfo({
    required this.titulo,
    required this.valor,
    required this.icone,
    required this.destaque,
    required this.card,
    required this.borda,
    required this.textoPrincipal,
    required this.textoSecundario,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: destaque
            ? AppCores.laranja.withOpacity(0.07)
            : card,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: destaque
              ? AppCores.laranja.withOpacity(0.55)
              : borda,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icone,
            color: destaque
                ? AppCores.laranja
                : textoSecundario,
            size: 19,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    color: textoSecundario,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  valor,
                  style: TextStyle(
                    color: destaque
                        ? AppCores.laranja
                        : textoPrincipal,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}