import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_cars/src/models/car_model.dart';
import 'package:teste_cars/src/models/lead_model.dart';
import 'package:teste_cars/src/repository/car_repository.dart';
import 'package:teste_cars/src/utils/loggy/types.dart';
import 'car_event.dart';
import 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> with CarBlocLoggy {
  final CarRepository carRepository;

  CarBloc({required this.carRepository}) : super(CarInitial()) {
    on<FetchCars>(_onFetchCars);
    on<SubmitLead>(_onSubmitLead);
  }

  Future<void> _onFetchCars(FetchCars event, Emitter<CarState> emit) async {
    emit(CarLoadInProgress());
    try {
      final List<Car> cars = await carRepository.fetchCars();
      loggy.debug("Carregamento sucesso: ${cars.length} carros carregados.");
      emit(CarLoadSuccess(cars: cars));
    } catch (error) {
      loggy.debug("Erro ao carregar carros: $error");
      emit(CarLoadFailure(error: error.toString()));
    }
  }

  Future<void> _onSubmitLead(SubmitLead event, Emitter<CarState> emit) async {
    loggy.debug('Iniciando processo de submissão do Lead...');
    try {
      final lead = Lead(
        name: event.name,
        email: event.email,
        phone: event.phone,
        carId: event.carId,
      );

      loggy.debug('Salvando Lead no banco de dados local...');
      await carRepository.submitLead(
        name: lead.name,
        email: lead.email,
        phone: lead.phone,
        carId: lead.carId,
      );

      loggy.debug('Tentando enviar Lead para o servidor...');
      await carRepository.sendLeadToServer(lead: lead);

      loggy.debug('Lead enviado com sucesso!');
      emit(LeadSubmissionSuccess(message: 'Lead submitted successfully'));

      final List<Car> cars = await carRepository.fetchCars();
      emit(CarLoadSuccess(cars: cars));
    } catch (error) {
      loggy.debug('Erro durante a submissão do Lead: $error');
      var errorMessage = error.toString();
      if (errorMessage.startsWith('Exception: ')) {
        errorMessage = errorMessage.replaceFirst('Exception: ', '');
      }
      emit(LeadSubmissionFailure(error: errorMessage));
    }
  }
}
