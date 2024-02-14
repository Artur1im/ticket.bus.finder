import 'package:bus_finder/bloc/bus_bloc.dart';
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
  final BusBloc busBloc = BusBloc();

  get bus => [];

  @override
  void initState() {
    bus.set(BusFetchingListInitial());
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
            if (state is BusLoadEvent) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (state is BusFetchingSuccessfulState) {
              final bus = state.bus;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const SizedBox(height: 20),
                Input(
                  title: 'Откуда',
                  onChanged: (value) {
                    busBloc.departure(value);
                  },
                ),
                const SizedBox(height: 20),
                Input(
                  onChanged: (value) {
                    busBloc.destination(value);
                  },
                  title: 'Куда',
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
                      onChanged: (text) {
                        busBloc.data(text);
                      },
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
                        } else {}
                      },
                    ),
                  ),
                ),
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                        Text('Выберите Откуда и Куда и выберите дату отправки'),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    CustomButton(
                      title: 'Найти Автобус',
                      onPressed: (value) {
                        busBloc.departure(value);
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
                              itemCount: bus.length,
                              itemBuilder: (context, index) {
                                // final bus = state.bus[index];
                                return Card(
                                  color: const Color.fromRGBO(252, 252, 252, 1),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(bus.departure),
                                            Text(bus.destination),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(bus.routeName),
                                                const SizedBox(height: 5.0),
                                                const Icon(
                                                    Icons.directions_bus),
                                                Text(
                                                    'Отбытие\n${bus.departureTime}'),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('${bus.distance} км'),
                                                const SizedBox(
                                                  width: 100,
                                                  child: Divider(
                                                      color: Colors.black),
                                                ),
                                                Text('${bus.duration} часов')
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(height: 5.0),
                                                const Icon(
                                                    Icons.directions_bus),
                                                Text(
                                                    'Прибытие\n${bus.destination}'),
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
            );
          }),
    );
  }
}
