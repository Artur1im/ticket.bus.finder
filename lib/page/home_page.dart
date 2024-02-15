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
                  state is BusFetchingSuccessfulState ? state.trips : [];

              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(children: [
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
                                    DateFormat('yyyy-MM-dd').format(pickedDate);

                                setState(() {
                                  dateController.text = formattedDate;
                                });

                                busBloc.date = formattedDate;
                              } else {}
                            },
                          ),
                        ),
                      ),
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'Выберите Откуда и Куда и выберите дату отправки'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          CustomButton(
                            title: 'Найти Автобус',
                            onPressed: () {
                              // Запуска2й
                              busBloc.add(BusFetchEvent());
                            },
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  padding: const EdgeInsets.all(15),
                                  child: ListView.builder(
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
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(trip.departure.name),
                                                  Text(trip.destination.name),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(trip.routeName),
                                                      const SizedBox(
                                                          height: 5.0),
                                                      const Icon(
                                                          Icons.directions_bus),
                                                      Text(
                                                          'Отбытие\n${trip.departureTime}'),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          '${trip.distance} км'),
                                                      const SizedBox(
                                                        width: 100,
                                                        child: Divider(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                          '${trip.duration} часов')
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const SizedBox(
                                                          height: 5.0),
                                                      const Icon(
                                                          Icons.directions_bus),
                                                      Text(
                                                          'Прибытие\n${trip.destination}'),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
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
