import 'package:bloc/bloc.dart';
import 'package:bus_finder/model.dart/bus_model.dart';

part 'bus_event.dart';
part 'bus_state.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  List<BusModel> bus = [];

  BusBloc(super.initialState);
}
