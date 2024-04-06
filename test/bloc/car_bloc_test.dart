import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teste_cars/src/bloc/car_bloc.dart';
import 'package:teste_cars/src/bloc/car_event.dart';
import 'package:teste_cars/src/bloc/car_state.dart';
import 'package:teste_cars/src/models/car_model.dart';
import 'package:teste_cars/src/models/lead_model.dart';
import 'package:teste_cars/src/repository/car_repository.dart';

class MockCarRepository extends Mock implements CarRepository {}

class FakeLead extends Fake implements Lead {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeLead());
  });

  group('CarBloc', () {
    late CarRepository mockCarRepository;
    late CarBloc carBloc;

    setUp(() {
      mockCarRepository = MockCarRepository();
      carBloc = CarBloc(carRepository: mockCarRepository);
    });

    test('should emit CarLoadSuccess when FetchCars is added', () async {
      when(() => mockCarRepository.fetchCars()).thenAnswer(
        (_) async => [
          Car(
              id: 1,
              nomeModelo: 'Test Car',
              valor: 10000,
              ano: 2018,
              combustivel: '',
              numPortas: 4,
              cor: '')
        ],
      );

      final List<CarState> emittedStates = [];
      final expectEmittedStates = [CarLoadInProgress, CarLoadSuccess];

      carBloc.stream.listen(emittedStates.add);

      carBloc.add(FetchCars());

      await untilCalled(() => mockCarRepository.fetchCars());
      await Future.delayed(const Duration(seconds: 1));

      expect(emittedStates.map((e) => e.runtimeType),
          containsAll(expectEmittedStates));
    });

    test('should emit CarLoadFailure when fetching cars fails', () async {
      const errorMessage = 'Error fetching cars';
      when(() => mockCarRepository.fetchCars())
          .thenThrow(Exception(errorMessage));

      final List<CarState> emittedStates = [];
      carBloc.stream.listen(emittedStates.add);

      carBloc.add(FetchCars());

      await untilCalled(() => mockCarRepository.fetchCars());
      await Future.delayed(const Duration(seconds: 1));

      expect(emittedStates, isNotEmpty);
      expect(emittedStates.last, isA<CarLoadFailure>());
    });

    test('should emit LeadSubmissionFailure when submitting lead fails',
        () async {
      const exceptionMessage = 'Failed to submit lead';

      when(() => mockCarRepository.submitLead(
            name: any(named: 'name'),
            email: any(named: 'email'),
            phone: any(named: 'phone'),
            carId: any(named: 'carId'),
          )).thenThrow(Exception(exceptionMessage));

      final List<CarState> emittedStates = [];
      carBloc.stream.listen(emittedStates.add);

      carBloc.add(SubmitLead(
        name: 'Test Name',
        email: 'test@test.com',
        phone: '1234567890',
        carId: 1,
      ));

      await untilCalled(() => mockCarRepository.submitLead(
            name: any(named: 'name'),
            email: any(named: 'email'),
            phone: any(named: 'phone'),
            carId: any(named: 'carId'),
          ));
      await Future.delayed(const Duration(seconds: 1));

      expect(emittedStates, isNotEmpty);
      expect(emittedStates.last, isA<LeadSubmissionFailure>());
      expect((emittedStates.last as LeadSubmissionFailure).error,
          'Failed to submit lead');
    });
  });
}
