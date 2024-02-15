import 'package:bus_finder/api.dart/api.dart';
import 'package:bus_finder/model.dart/bus_model.dart';

class BusApi extends Api {
  Future<List<BusModel>> getTrips({
    required String departure,
    required String destination,
    required String date,
  }) async {
    Map<String, dynamic> data = await get(
      '/search_trips_cities/',
      params: {
        'departure_city': departure,
        'destination_city': destination,
        'date': date
      },
    );

    return BusModel.fromJsonToList(data);
  }
}
