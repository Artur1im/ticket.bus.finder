part of 'bus_bloc.dart';

sealed class BusState {}

class BusFetchingListInitial extends BusState {}

class BusFetchingLoadingState extends BusState {}

class BusFetchingSuccessfulState extends BusState {
  final List<BusModel> trips;

  BusFetchingSuccessfulState({
    required this.trips,
  });
}
