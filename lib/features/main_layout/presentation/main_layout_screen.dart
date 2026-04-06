import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../dashboard/presentation/dashboard_screen.dart';
import '../../profile/presentation/profile_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0; // Índice de la pestaña actual

  // Lista de las pantallas que mostraremos
  final List<Widget> _screens = [
    const DashboardScreen(),
    const Center(child: Text('Pantalla Tarjetas')), // Temporal
    const Center(child: Text('Pantalla Pagos')), // Temporal
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El cuerpo principal mostrará la pantalla correspondiente al índice
      body: SafeArea(child: _screens[_currentIndex]),
      // La barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Actualiza la vista al hacer clic
          });
        },
        type: BottomNavigationBarType.fixed, // Mantiene los colores fijos
        selectedItemColor: AppTheme.primaryNavy,
        unselectedItemColor: AppTheme.textSecondary,
        backgroundColor: Colors.white,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'INICIO',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'TARJETAS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_outlined),
            label: 'PAGOS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'PERFIL',
          ),
        ],
      ),
    );
  }
}
