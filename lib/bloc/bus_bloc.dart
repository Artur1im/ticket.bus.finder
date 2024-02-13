import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bus_finder/model.dart/bus_model.dart';

part 'bus_event.dart';
part 'bus_state.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  late String _departure;
  late String _destination;
  late String _data;

  List<BusModel> bus = [];

  BusBloc() : super(BusFetchingListInitial()) {
    on<BusLoadEvent>(busLoadEvent);
    on<BusFetchEvent>(busFetchEvent);
    on<BusInitialEvent>(busInitialEvent);
  }

  FutureOr<void> busLoadEvent(
      BusLoadEvent event, Emitter<BusState> emit) async {
    emit(BusFetchingLoadingState());
    emit(BusFetchingSuccessfulState(bus: bus));
  }

  FutureOr<void> busFetchEvent(
      BusFetchEvent event, Emitter<BusState> emit) async {
    emit(BusFetchingLoadingState());
    emit(BusFetchingSuccessfulState(bus: bus));
  }

  FutureOr<void> busInitialEvent(
      BusInitialEvent event, Emitter<BusState> emit) async {
    emit(BusFetchingLoadingState());
    emit(BusFetchingSuccessfulState(bus: bus));
  }

  get departure => _departure;

  set departure(value) => _departure = value;

  get destination => _destination;

  set destination(value) => _destination = value;

  get data => _data;

  set data(value) => _data = value;
}
