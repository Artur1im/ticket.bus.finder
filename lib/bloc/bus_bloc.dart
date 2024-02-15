// bus_bloc.dart

import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:bus_finder/api.dart/bus_api.dart';
import 'package:bus_finder/model.dart/bus_model.dart';

part 'bus_event.dart';
part 'bus_state.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  String _departure = '';
  String _destination = '';
  String _date = '';

  List<BusModel> bus = [];

  BusBloc() : super(BusFetchingListInitial()) {
    on<BusFetchEvent>(busFetchEvent);
    on<BusInitialEvent>(busInitialEvent);
  }

  FutureOr<void> busFetchEvent(
      BusFetchEvent event, Emitter<BusState> emit) async {
    emit(BusFetchingLoadingState());
    log('$_departure $_destination $_date');
    List<BusModel> collection = await BusApi().getTrips(
      date: _date,
      departure: _departure,
      destination: _destination,
    );
    emit(BusFetchingSuccessfulState(trips: collection));
  }

  FutureOr<void> busInitialEvent(
      BusInitialEvent event, Emitter<BusState> emit) async {
    emit(BusFetchingSuccessfulState(trips: []));
  }

  String get departure => _departure;

  set departure(String value) => _departure = value;

  get destination => _destination;

  set destination(value) => _destination = value;

  get date => _date;

  set date(value) => _date = value;
}
