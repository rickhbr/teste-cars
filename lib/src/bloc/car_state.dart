import 'package:teste_cars/src/models/car_model.dart';

abstract class CarState {}

class CarInitial extends CarState {}

class CarLoadInProgress extends CarState {}

class CarLoadSuccess extends CarState {
  final List<Car> cars;

  CarLoadSuccess({required this.cars});
}

class CarLoadFailure extends CarState {
  final String error;

  CarLoadFailure({required this.error});
}

class LeadSubmissionSuccess extends CarState {
  final String message;

  LeadSubmissionSuccess({required this.message});
}

class LeadSubmissionFailure extends CarState {
  final String error;

  LeadSubmissionFailure({required this.error});
}

class LeadSubmissionInProgress extends CarState {}
