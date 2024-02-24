import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/additional_info.dart';
import 'package:weatherapp/hourlyforecast.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/api_key.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  late Future<Map<String, dynamic>> weather;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Kochi';
      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey&units=metric'));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw data['message'];
      }
      return data;
    } catch (e) {
      throw (e).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  weather = getCurrentWeather();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data!;
          final weatherdata = data['list'][0];
          final currentTemp = weatherdata['main']['temp'];
          final currentSky = weatherdata['weather'][0]['main'];
          final pressure = weatherdata['main']['pressure'];
          final windSpeed = weatherdata['wind']['speed'];
          final humidity = weatherdata['main']['humidity'];
          const String city = 'Kochi';
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Center(
                child: Text(city,
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              '$currentTemp',
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              currentSky == 'Clouds' || currentSky == 'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny,
                              size: 80,
                            ),
                            Text(
                              '$currentSky',
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'weather forecast',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final hourlyForecast = data['list'][index + 1];
                    final hourlySky =
                        data['list'][index + 1]['weather'][0]['main'];
                    final hourlyTemp =
                        hourlyForecast['main']['temp'].toString();
                    final time = DateTime.parse(hourlyForecast['dt_txt']);
                    return HourelyForecast(
                      time: DateFormat.j().format(time),
                      temp: hourlyTemp,
                      icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                          ? Icons.cloud
                          : Icons.sunny,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'additional info',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Addintionalinfoitem(
                    icon: Icons.water_drop,
                    title: 'Humidity',
                    value: '$humidity',
                  ),
                  Addintionalinfoitem(
                    icon: Icons.wind_power,
                    title: 'Wind Spedd',
                    value: '$windSpeed',
                  ),
                  Addintionalinfoitem(
                    icon: Icons.umbrella,
                    title: 'Pressure',
                    value: '$pressure',
                  )
                ],
              )
            ]),
          );
        },
      ),
    );
  }
}
