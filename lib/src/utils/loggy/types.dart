import 'package:loggy/loggy.dart';

mixin SendLeadLoggy implements LoggyType {
  @override
  Loggy<SendLeadLoggy> get loggy =>
      Loggy<SendLeadLoggy>('Send Lead Loggy - ${runtimeType.toString()}');
}

mixin ApiClientLoggy implements LoggyType {
  @override
  Loggy<ApiClientLoggy> get loggy =>
      Loggy<ApiClientLoggy>('API CLient Loggy - ${runtimeType.toString()}');
}

mixin CarBlocLoggy implements LoggyType {
  @override
  Loggy<CarBlocLoggy> get loggy =>
      Loggy<CarBlocLoggy>('Car Bloc Loggy - ${runtimeType.toString()}');
}
