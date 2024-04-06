abstract class CarEvent {}

class FetchCars extends CarEvent {}

class SubmitLead extends CarEvent {
  final String name;
  final String email;
  final String phone;
  final int carId;

  SubmitLead(
      {required this.name,
      required this.email,
      required this.phone,
      required this.carId});
}
