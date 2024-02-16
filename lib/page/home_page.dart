import 'dart:developer';

import 'package:bus_finder/bloc/bus_bloc.dart';
import 'package:bus_finder/model.dart/bus_model.dart';
import 'package:bus_finder/widget/custom_button.dart';
import 'package:bus_finder/widget/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late dynamic text = '';
  TextEditingController dateController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController departureController = TextEditingController();
  final BusBloc busBloc = BusBloc();

  List<BusModel> trips = [];

  @override
  void initState() {
    busBloc.add(BusInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Finder Bus'),
        centerTitle: true,
      ),
      body: BlocBuilder<BusBloc, BusState>(
          bloc: busBloc,
          builder: (context, state) {
            log(state.toString());

            if (state is BusFetchingSuccessfulState) {
              List<BusModel> trips =
                  // ignore: unnecessary_type_check
                  state is BusFetchingSuccessfulState ? state.trips : [];

              return SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Input(
                            title: 'Откуда',
                            value: busBloc.departure,
                            onChanged: (String value) {
                              busBloc.departure = value.trim();
                            },
                          ),
                          const SizedBox(height: 20),
                          Input(
                            title: 'Куда',
                            value: busBloc.destination,
                            onChanged: (String value) {
                              busBloc.destination = value.trim();
                            },
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black),
                            ),
                            width: 180,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: dateController,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.calendar_today),
                                  labelText: "Выберите дату",
                                ),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);

                                    setState(() {
                                      dateController.text = formattedDate;
                                    });

                                    busBloc.date = formattedDate;
                                  } else {}
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          CustomButton(
                            title: 'Найти Автобус',
                            onPressed: () {
                              busBloc.add(BusFetchEvent());
                            },
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                padding: const EdgeInsets.all(15),
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    busBloc.add(BusFetchEvent());
                                  },
                                  child: ListView.builder(
                                    padding: const EdgeInsets.only(bottom: 100),
                                    scrollDirection: Axis.vertical,
                                    itemCount: trips.length,
                                    itemBuilder: (context, index) {
                                      final BusModel trip = trips[index];
                                      return Card(
                                        color: const Color.fromRGBO(
                                            252, 252, 252, 1),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                  child: Text(trip.routeName)),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                      width: 100,
                                                      child: Text(
                                                          trip.departure.name)),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: Icon(
                                                      Icons
                                                          .arrow_circle_right_rounded,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: 100,
                                                      child: Text(trip
                                                          .destination.name)),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(
                                                    children: [
                                                      const Icon(
                                                          Icons.directions_bus),
                                                      SizedBox(
                                                        width: 80,
                                                        child: Text(
                                                            'Отбытие\n${trip.departureTime}'),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 50,
                                                        child: Text(
                                                            '${trip.distance} км'),
                                                      ),
                                                      const SizedBox(
                                                        width: 50,
                                                        child: Divider(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                          '${trip.duration} часов')
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      const SizedBox(
                                                          height: 5.0),
                                                      const Icon(
                                                          Icons.directions_bus),
                                                      SizedBox(
                                                        width: 80,
                                                        child: Text(
                                                            'Прибытие\n${trip.arrivalTime}'),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }),
    );
  }
}
