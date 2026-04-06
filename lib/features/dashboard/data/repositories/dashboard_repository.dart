import '../../domain/models/dashboard_data.dart';

class DashboardRepository {
  // Simulamos una llamada asíncrona a un servidor
  Future<DashboardData> fetchDashboardInfo() async {
    // Retrasamos la respuesta 2 segundos para ver la animación de carga
    await Future.delayed(const Duration(seconds: 2));

    // Simulamos que la base de datos nos devolvió esto:
    return DashboardData(
      userName: 'Esteban',
      balance: 12450.00,
      accountNumber: '20003452789',
    );
  }
}
