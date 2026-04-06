import 'package:flutter_bloc/flutter_bloc.dart';
// ¡Solo dos niveles hacia atrás (../../) para llegar a la raíz de 'dashboard'!
import '../../data/repositories/dashboard_repository.dart';
import '../../domain/models/dashboard_data.dart';

// --- 1. EVENTOS (Lo que la UI le pide al BLoC) ---
abstract class DashboardEvent {}

class LoadDashboardData extends DashboardEvent {} // Evento para pedir datos

// --- 2. ESTADOS (Lo que el BLoC le responde a la UI) ---
abstract class DashboardState {}

class DashboardInitial extends DashboardState {} // Estado inicial (vacío)

class DashboardLoading extends DashboardState {} // Estado de "Cargando"

class DashboardLoaded extends DashboardState {
  // Estado de "Éxito"
  final DashboardData data;
  DashboardLoaded(this.data);
}

class DashboardError extends DashboardState {
  // Estado de "Fallo"
  final String message;
  DashboardError(this.message);
}

// --- 3. EL BLOC (El cerebro) ---
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;

  // Inyectamos el repositorio por el constructor
  DashboardBloc({required this.repository}) : super(DashboardInitial()) {
    // Le decimos qué hacer cuando reciba el evento "LoadDashboardData"
    on<LoadDashboardData>((event, emit) async {
      emit(DashboardLoading()); // 1. Avisamos a la UI que estamos cargando

      try {
        // 2. Pedimos los datos al repositorio
        final data = await repository.fetchDashboardInfo();

        // 3. Si todo sale bien, emitimos el estado de éxito con los datos
        emit(DashboardLoaded(data));
      } catch (e) {
        // 4. Si algo falla, emitimos el error
        emit(DashboardError("No se pudieron cargar los datos del banco."));
      }
    });
  }
}
