part of 'bus_bloc.dart';

sealed class BusState {}

class BusFetchingListInitial extends BusState {}

class BusFetchingLoadingState extends BusState {}

class BusFetchingErrorState extends BusState {}

class BusFetchingSuccessfulState extends BusState {
  final List<BusModel> bus;

  BusFetchingSuccessfulState({
    required this.bus,
  });
}
