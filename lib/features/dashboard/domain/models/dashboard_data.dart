// Esta clase representa toda la información que necesita la pantalla principal
class DashboardData {
  final String userName;
  final double balance;
  final String accountNumber;
  // En un proyecto real, las tarjetas y transacciones serían sus propios modelos,
  // pero para mantenerlo ágil, las simularemos directamente en el repositorio por ahora.

  DashboardData({
    required this.userName,
    required this.balance,
    required this.accountNumber,
  });
}
