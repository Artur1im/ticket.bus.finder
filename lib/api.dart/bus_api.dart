import 'package:bus_finder/api.dart/api.dart';
import 'package:bus_finder/api.dart/apr_error.dart';
import 'package:bus_finder/model.dart/bus_model.dart';

class BusApi extends Api {
  Future<Map<String, dynamic>> getTrips(
      {required String departure,
      required String destination,
      required String date}) async {
    try {
      Map<String, dynamic> data = await get('search_trips_cities/',
          params: {'departure_city': '', 'destination_city': '', 'date': ''});

      return {
        'trips': BusModel.fromJsonToList(data),
      };
    } on ApiError catch (_) {
      return {};
    }
  }
}
