import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/error/error_handler.dart';
import 'package:weather_app/model/repo.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_icons/weather_icons.dart';

import '../widget/date_time.dart';
import '../widget/scroll_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//next
  final Celsus = 273.15;

  TextEditingController controller = TextEditingController();
  WeatherModel? weatherModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      if (controller.text.isNotEmpty) {
        weatherModel = await Repo().getWeather(controller.text);
      } else {
        weatherModel = await Repo().getWeather('kathmandu');
      }
      setState(() {});
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 129, 188, 237),
      //extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) async {
                  try {
                    weatherModel = await Repo().getWeather(controller.text);
                    setState(() {});
                    // trigger a rebuild to update UI
                  } catch (e) {
                    Utils().toastMessage(e.toString());
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'City',
                    focusColor: Colors.red,
                    hintStyle: const TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MyContainer(
              width: 370,
              height: 253,
              color: Color.fromARGB(255, 176, 201, 223),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                child: Row(children: [
                  if (weatherModel != null)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              weatherModel!.name.toString(),
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white),
                            ),
                            const Icon(Icons.location_on, color: Colors.white)
                          ],
                        ),
                        CurrentTimeAndDay(),
                        Container(
                          width: 165,
                          height: 2,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              '${(weatherModel!.main!.temp! - Celsus).toInt()}°C',
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Image.asset(
                              'images/sun.gif',
                              width: 90,
                              height: 60,
                            ),
                            //Icon(WeatherIcons.sunrise)
                          ],
                        ),
                        Text(
                          'feels like ${(weatherModel!.main!.feelsLike! - Celsus).toInt()}°C',
                          style: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    )
                  else
                    const Text('No Data'),
                ]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const MyContainer(
                width: 370,
                height: 100,
                color: Color.fromARGB(255, 176, 201, 223),
                child: Center(
                    child: Text(
                        "Tomorrow's Temperature\nAlmost the same as today",
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: Colors.white)))),
            const SizedBox(
              height: 20,
            ),
            MyContainer(
              width: 370,
              height: 157,
              color: const Color.fromARGB(255, 176, 201, 223),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 60),
                        child: Column(
                          children: const [
                            Text('Sunrise\n5:45 am',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white)),
                            Icon(
                              Icons.sunny_snowing,
                              size: 70,
                              color: Color.fromARGB(207, 185, 185, 74),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 55),
                        child: Column(
                          children: const [
                            Text('Sunset\n6:23 pm',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white)),
                            Icon(
                              Icons.sunny_snowing,
                              size: 70,
                              color: Color.fromARGB(255, 214, 91, 82),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MyContainer(
              width: 370,
              height: 157,
              color: const Color.fromARGB(255, 176, 201, 223),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.circle,
                                size: 50,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 80,
                              ),
                              Icon(
                                Icons.water_drop_outlined,
                                size: 50,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Icon(
                                Icons.air,
                                size: 50,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('UV index\n Low',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white)),
                              const SizedBox(
                                width: 35,
                              ),
                              Text(
                                'Humidity\n${weatherModel?.main?.humidity ?? ""}%',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 28,
                              ),
                              Text(
                                'Wind\n${weatherModel?.wind?.speed ?? ""}Km/h',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
