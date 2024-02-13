part of 'bus_bloc.dart';

sealed class BusEvent {}

class BusLoadEvent extends BusEvent {}

class BusFetchEvent extends BusEvent {}

class BusInitialEvent extends BusEvent {}
