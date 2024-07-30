import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskk2/Models/constants.dart';
import 'package:taskk2/components/weatheritem.dart';

class detailPage extends StatefulWidget {
  final dailyForecastWeather;
  const detailPage({Key? key, this.dailyForecastWeather}) : super(key: key);

  @override
  State<detailPage> createState() => _detailPageState();
}

class _detailPageState extends State<detailPage> {
  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;

    // Function to get weather
    Map getForecastWeather(int index) {
      int maxWindSpeed = weatherData[index]["day"]["maxwind_kph"]?.toInt() ?? 0;
      int avgHumidity = weatherData[index]["day"]["avghumidity"]?.toInt() ?? 0;
      int chanceOfRain =
          weatherData[index]["day"]["daily_chance_of_rain"]?.toInt() ?? 0;

      var parsedDate = DateTime.parse(weatherData[index]["date"]);
      var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);
      String weatherName =
          weatherData[index]["day"]["condition"]["text"] ?? "Unknown";
      String weatherIcon =
          weatherName.replaceAll(' ', '').toLowerCase() + ".png";
      int minTemperature = weatherData[index]["day"]["mintemp_c"]?.toInt() ?? 0;
      int maxTemperature = weatherData[index]["day"]["maxtemp_c"]?.toInt() ?? 0;

      var forecastData = {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'chanceOfRain': chanceOfRain,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'minTemperature': minTemperature,
        'maxTemperature': maxTemperature
      };
      return forecastData;
    }

    return Scaffold(
        backgroundColor: _constants.primaryColor,
        appBar: AppBar(
          title: const Text('Forecasts',
              style: TextStyle(
                color: Colors.white,
              )),
          centerTitle: true,
          backgroundColor: _constants.primaryColor,
          elevation: 0.0,
        ),
        body: SizedBox(
          height: size.height * .86,
          child: ListView.builder(
            itemCount: 5, // Number of days to forecast
            itemBuilder: (BuildContext context, int index) {
              var forecast = getForecastWeather(index);
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.center,
                      colors: [
                        Color(0xffa9c1f5),
                        Color(0xff6696f5),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(.1),
                        offset: const Offset(0, 25),
                        blurRadius: 3,
                        spreadRadius: -10,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            forecast['forecastDate'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                            ),
                          ),
                          subtitle: Text(
                            forecast['weatherName'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Weatheritem(
                              text: 'Wind Speed',
                              value: forecast['maxWindSpeed'],
                              unit: "km/h",
                              imageUrl: "assets/wingsign.jpeg",
                            ),
                            Weatheritem(
                              text: 'Humidity',
                              value: forecast['avgHumidity'],
                              unit: "%",
                              imageUrl: "assets/2322701.png",
                            ),
                            Weatheritem(
                              text: 'Chance of Rain',
                              value: forecast['chanceOfRain'],
                              unit: "%",
                              imageUrl: "assets/cloudy.png",
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Min Temp',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${forecast['minTemperature']}°',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Max Temp',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${forecast['maxTemperature']}°',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
