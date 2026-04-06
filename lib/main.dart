import 'package:banco_perla/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const BancoPerlaApp());
}

class BancoPerlaApp extends StatelessWidget {
  const BancoPerlaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banco Perla',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // Configuración de responsividad
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        ],
      ),
      home: const LoginScreen(),
    );
  }
}

// Un widget temporal solo para verificar que la app compila
/*
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Banco Perla - Core Inicializado',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Botón de Prueba'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
