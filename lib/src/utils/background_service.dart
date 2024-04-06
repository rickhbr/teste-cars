import 'package:teste_cars/src/utils/loggy/types.dart';
import 'package:workmanager/workmanager.dart';
import 'package:teste_cars/src/utils/inject/injector.dart';

class SendLeadTask with SendLeadLoggy {
  final carRepository = Injector.provideCarRepository();

  Future<bool> execute() async {
    loggy.info('Fetching unsent leads...');
    final unsentLeads = await carRepository.getUnsentLeads();
    loggy.info('Found ${unsentLeads.length} unsent leads');

    for (var lead in unsentLeads) {
      try {
        loggy.info('Sending lead to server: ${lead.carId}');
        await carRepository.sendLeadToServer(lead: lead);
        await carRepository.markLeadAsSent(lead.carId);
        loggy.info('Lead sent successfully: ${lead.carId}');
      } catch (e) {
        loggy.error('Failed to send lead: ${lead.carId}, Error: $e');
        return false;
      }
    }
    return true;
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    SendLeadTask taskExecutor = SendLeadTask();
    bool result = await taskExecutor.execute();
    return Future.value(result);
  });
}
