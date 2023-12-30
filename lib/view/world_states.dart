import 'package:covid_19_tracker_app/Model/world_states_model.dart';
import 'package:covid_19_tracker_app/Services/states_services.dart';
import 'package:covid_19_tracker_app/components/reusable_row.dart';
import 'package:covid_19_tracker_app/view/countries_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  StatesServices statesServices = StatesServices();
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
                future: statesServices.fetchWorldStates(),
                builder: (context, AsyncSnapshot<WorldStatesApi> snapshot) {
                  if (!snapshot.hasData) {
                    return const Expanded(
                        child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50,
                    ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total': snapshot.data!.cases!.toDouble(),
                            'Recovered': snapshot.data!.recovered!.toDouble(),
                            'Death': snapshot.data!.deaths!.toDouble(),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                          colorList: colorList,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          chartType: ChartType.ring,
                          animationDuration: const Duration(milliseconds: 1200),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(
                                  title: 'Total',
                                  value: snapshot.data!.cases!.toString(),
                                ),
                                ReusableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered!.toString(),
                                ),
                                ReusableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths!.toString(),
                                ),
                                ReusableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active!.toString(),
                                ),
                                ReusableRow(
                                  title: 'Critical',
                                  value: snapshot.data!.critical!.toString(),
                                ),
                                ReusableRow(
                                  title: 'Affected Countries',
                                  value: snapshot.data!.affectedCountries!
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CountriesList(),
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(15)),
                            child: const Center(
                              child: Text('Track Countries'),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}
