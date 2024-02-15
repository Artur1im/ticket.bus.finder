import 'package:bus_finder/model.dart/station.dart';

class BusModel {
  String routeName;
  String status;
  String? statusPrint;
  int duration;
  Station departure;
  Station destination;
  String distance;
  String departureTime;

  BusModel.fromJson(Map<String, dynamic> data)
      : routeName = data['RouteName'],
        status = data['Status'],
        statusPrint = data['StatusPrint'],
        duration = data['Duration'],
        departure = Station.fromJson(data['Departure']),
        destination = Station.fromJson(data['Destination']),
        distance = data['Distance'],
        departureTime = data['DepartureTime'];

  static List<BusModel> fromJsonToList(data) {
    List<BusModel> collection =
        (data['trips'] as List).map((item) => BusModel.fromJson(item)).toList();
    return collection;
  }
}
