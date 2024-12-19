import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/weather_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherController>().loadWether('Surat');
  }

  late WeatherController weatherW;
  late WeatherController weatherR;
  @override
  Widget build(BuildContext context) {
    weatherW = Provider.of<WeatherController>(context, listen: false);
    weatherR = Provider.of<WeatherController>(context, listen: true);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/c-bg.jpg',
              ),
              fit: BoxFit.cover),
        ),
        padding: const EdgeInsets.only(top: 60),
        child: Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        weatherR.addCity(
                            city: weatherW.cityName, context: context);
                      },
                      icon: const Icon(
                        CupertinoIcons.location_solid,
                        color: Colors.white,
                        size: 28,
                      )),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (value) {
                        weatherR.loadWether(value);
                        weatherW.cityName = value;
                      },
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter any Location",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    iconColor: Colors.white,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () {
                          showModalBottomSheet(
                            showDragHandle: true,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return DraggableScrollableSheet(
                                expand: false,
                                builder: (context, scrollController) {
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.search),
                                            const Text(
                                              'BookMark Cities',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextButton.icon(
                                              onPressed: () {
                                                weatherW.bookMarkedCities
                                                    .clear();
                                                Navigator.pop(context);
                                              },
                                              label: const Text('Clear'),
                                              icon: const Icon(Icons.clear),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        weatherW.bookMarkedCities.isNotEmpty
                                            ? Expanded(
                                                child: ListView.builder(
                                                  controller: scrollController,
                                                  itemCount: weatherW
                                                      .bookMarkedCities.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final weather = weatherW
                                                            .bookMarkedCities[
                                                        index];
                                                    return ListTile(
                                                      onTap: () {
                                                        weatherW.addCity(
                                                            city: weather,
                                                            context: context);
                                                        Navigator.pop(context);
                                                      },
                                                      title: Text(weather),
                                                      trailing: IconButton(
                                                          onPressed: () {
                                                            weatherR.removeCity(
                                                                index);
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete)),
                                                    );
                                                  },
                                                ),
                                              )
                                            : const Center(
                                                child: Text(
                                                  "No Any BookMark Yet... 😓😓",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.search),
                            Text(
                              'BookMark Places',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, right: 40),
                                    padding: const EdgeInsets.only(
                                        left: 40, top: 15, bottom: 20),
                                    height: 215,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/square.png'),
                                          fit: BoxFit.fill),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          textAlign: TextAlign.center,
                                          '${weatherW.weather?.main?.temp}℃',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                          ),
                                        ),
                                        const Divider(),
                                        Text(
                                          textAlign: TextAlign.center,
                                          '${weatherW.weather?.name}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                          ),
                                        ),
                                        Text(
                                          textAlign: TextAlign.center,
                                          '${weatherW.weather?.weather?[0].main}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Image.asset('assets/images/cloudy.png'),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Weather Details',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                ),
                              ),
                            ),
                            GridView.builder(
                              itemCount: 8,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                              itemBuilder: (context, index) {
                                final details = [
                                  [
                                    "Country",
                                    (weatherW.weather?.sys?.country ?? '--'),
                                    Icons.air
                                  ],
                                  [
                                    "Humidity",
                                    "${weatherR.weather?.main?.humidity ?? '--'}%",
                                    Icons.water_drop
                                  ],
                                  [
                                    "Pressure",
                                    "${weatherR.weather?.main?.pressure ?? '--'} hPa",
                                    Icons.compress
                                  ],
                                  [
                                    "Feels Like",
                                    "${weatherR.weather?.main?.feels_like ?? '--'}℃",
                                    Icons.thermostat
                                  ],
                                  [
                                    "Wind Speed",
                                    "${weatherR.weather?.wind?.speed ?? '--'} m/s",
                                    Icons.wind_power
                                  ],
                                  [
                                    "Wind Degree",
                                    "${weatherW.weather?.wind?.deg ?? '--'}°",
                                    Icons.rotate_90_degrees_ccw_outlined
                                  ],
                                  [
                                    "Visibility",
                                    "${weatherR.weather?.visibility ?? '--'} m",
                                    Icons.visibility
                                  ],
                                  [
                                    "Sunrise",
                                    "${weatherR.weather?.sys?.sunrise ?? '--'}",
                                    Icons.sunny_snowing
                                  ],
                                ];
                                return buildWeatherDetailTile(
                                  details[index][0] as String,
                                  details[index][1] as String,
                                  details[index][2] as IconData,
                                );
                              },
                            ),
                            Image.asset(
                              'assets/images/Logo.png',
                              fit: BoxFit.cover,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWeatherDetailTile(String title, String value, IconData icon,
      [String? extra]) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage('assets/images/square.png'), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(30),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (extra != null)
                  Align(
                    child: Text(
                      extra,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
