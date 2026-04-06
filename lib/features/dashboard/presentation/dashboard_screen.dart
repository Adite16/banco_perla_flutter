import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../data/repositories/dashboard_repository.dart';
import 'bloc/dashboard_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. BlocProvider: Instancia el BLoC, le inyecta el repositorio y dispara el evento inicial
    return BlocProvider(
      create: (context) => DashboardBloc(repository: DashboardRepository())
        ..add(
          LoadDashboardData(),
        ), // Los dos puntos (..) son un atajo en Dart para ejecutar un método inmediatamente tras instanciar
      // 2. BlocBuilder: Escucha los estados y reconstruye la UI
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          // ESTADO 1: Cargando (Muestra un círculo de progreso)
          if (state is DashboardInitial || state is DashboardLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryNavy),
            );
          }

          // ESTADO 2: Error (Muestra mensaje rojo)
          if (state is DashboardError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // ESTADO 3: Éxito (Dibuja la pantalla con los datos reales)
          if (state is DashboardLoaded) {
            final data = state.data; // Extraemos nuestra entidad de datos

            return Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pasamos las variables dinámicas a nuestros componentes
                    _HeaderSection(userName: data.userName),
                    const SizedBox(height: 24),
                    _BalanceSection(
                      balance: data.balance,
                      account: data.accountNumber,
                    ),
                    const SizedBox(height: 24),
                    const _QuickActions(),
                    const SizedBox(height: 32),
                    _SectionTitle(
                      title: 'Mis tarjetas',
                      actionText: '+ Agregar',
                      onAction: () {},
                    ),
                    const SizedBox(height: 16),
                    const _CardsCarousel(),
                    const SizedBox(height: 32),
                    const _SectionTitle(
                      title: 'Actividad reciente',
                      actionText: '',
                      onAction: null,
                    ),
                    const SizedBox(height: 16),
                    const _RecentActivityList(),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink(); // Fallback de seguridad
        },
      ),
    );
  }
}

// =========================================================================
// COMPONENTES PRIVADOS ACTUALIZADOS
// =========================================================================

class _HeaderSection extends StatelessWidget {
  final String userName; // Ahora recibe el nombre de forma dinámica

  const _HeaderSection({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: AppTheme.primaryNavy,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text(
              'Hola, $userName', // Inyección de variable (Interpolación)
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(
            Icons.notifications_none,
            color: AppTheme.primaryNavy,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _BalanceSection extends StatelessWidget {
  final double balance;
  final String account;

  const _BalanceSection({required this.balance, required this.account});

  @override
  Widget build(BuildContext context) {
    // Formateamos el número para que siempre tenga 2 decimales
    final formattedBalance = balance.toStringAsFixed(2).replaceAll('.', ',');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Saldo disponible',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '\$$formattedBalance', // Mostramos el saldo dinámico
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 36,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Cta. $account', // Mostramos la cuenta dinámica
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
        ),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _ActionItem(icon: Icons.sync_alt, label: 'Transferir', onTap: () {}),
        _ActionItem(
          icon: Icons.receipt_long,
          label: 'Pagar servicios',
          onTap: () {},
        ),
        _ActionItem(icon: Icons.history, label: 'Movimientos', onTap: () {}),
      ],
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: AppTheme.primaryNavy),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? onAction;
  const _SectionTitle({
    required this.title,
    required this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        if (actionText.isNotEmpty)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionText,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}

class _CardsCarousel extends StatelessWidget {
  const _CardsCarousel();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        children: const [
          _CreditCardWidget(
            type: 'Visa',
            lastFour: '8842',
            balance: '\$12.450',
            isCredit: false,
          ),
          SizedBox(width: 16),
          _CreditCardWidget(
            type: 'Visa',
            lastFour: '1234',
            balance: '\$8.200',
            isCredit: true,
          ),
        ],
      ),
    );
  }
}

class _CreditCardWidget extends StatelessWidget {
  final String type, lastFour, balance;
  final bool isCredit;
  const _CreditCardWidget({
    required this.type,
    required this.lastFour,
    required this.balance,
    required this.isCredit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.primaryNavy,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryNavy.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.contactless_outlined, color: Colors.white),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isCredit ? 'CRÉDITO' : 'DÉBITO',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 10,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '•••• •••• •••• $lastFour',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          Text(
            balance,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentActivityList extends StatelessWidget {
  const _RecentActivityList();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          _TransactionTile(
            icon: Icons.shopping_bag_outlined,
            title: 'Apple Store',
            date: 'Noviembre 24, 2025',
            amount: '-\$199.00',
            isPositive: false,
          ),
          Divider(height: 1, indent: 60, endIndent: 20),
          _TransactionTile(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Transferencia recibida',
            date: 'Diciembre 22, 2025',
            amount: '+\$3,500.00',
            isPositive: true,
          ),
          Divider(height: 1, indent: 60, endIndent: 20),
          _TransactionTile(
            icon: Icons.restaurant_outlined,
            title: 'Blue Bottle Coffee',
            date: 'Enero 21, 2026',
            amount: '-\$12.50',
            isPositive: false,
          ),
          Divider(height: 1, indent: 60, endIndent: 20),
          _TransactionTile(
            icon: Icons.directions_car_outlined,
            title: 'Uber',
            date: 'Febrero 20, 2026',
            amount: '-\$7.00',
            isPositive: false,
          ),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final IconData icon;
  final String title, date, amount;
  final bool isPositive;
  const _TransactionTile({
    required this.icon,
    required this.title,
    required this.date,
    required this.amount,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.backgroundLightBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppTheme.textPrimary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(
        date,
        style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11),
      ),
      trailing: Text(
        amount,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: isPositive ? Colors.green : AppTheme.textPrimary,
        ),
      ),
    );
  }
}
