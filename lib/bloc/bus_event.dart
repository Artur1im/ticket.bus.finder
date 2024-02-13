part of 'bus_bloc.dart';

sealed class BusEvent {}

class BusLoadMore extends BusEvent {}

class BusFetchListInitial extends BusEvent {}

class BusApplyFilter extends BusEvent {}
