import 'package:bus_finder/api.dart/api.dart';
import 'package:bus_finder/api.dart/apr_error.dart';
import 'package:bus_finder/model.dart/bus_model.dart';

class BusApi extends Api {
  Future<Map<String, dynamic>> news({String? page}) async {
    try {
      Map<String, dynamic> data = await get('');

      return {
        'bus': BusModel.fromJsonToList(data['results']),
      };
    } on ApiError catch (_) {
      return {};
    }
  }
}
