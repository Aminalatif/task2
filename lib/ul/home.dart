
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taskk2/Models/constants.dart';
import 'package:taskk2/components/weatheritem.dart';
import 'package:taskk2/ul/detailpage.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _cityController = TextEditingController();
  final Constants _constants = Constants();
  static String API_KEY = '71c4902fde4a4b9ebcb101055241307';
  String location = 'haripur'; // Default
  String weatherText = 'Clear Sky';
  int temperature = 0;
  int windSpeed = 0;
  int humidity = 0;
  int cloud = 0;
  String currentDate = '';
  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];
  String currentWeatherStatus = '';

  // API Call
  String searchWeatherAPI = "https://api.weatherapi.com/v1/forecast.json?key=" +
      API_KEY +
      "&days=7&q=";

  void fetchWeatherData(String searchText) async {
    try {
      var searchResult =
      await http.get(Uri.parse(searchWeatherAPI + searchText));

      final weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? 'No Data');

      print('Weather Data: $weatherData'); // Debug print

      var locationData = weatherData["location"];
      var currentWeather = weatherData["current"];

      setState(() {
        location = getShortLocationName(locationData["name"]);
        var parsedDate =
        DateTime.parse(locationData["localtime"].substring(0, 10));
        var newDate = DateFormat('MMMMEEEEd').format(parsedDate);
        currentDate = newDate;

        // Update Weather
        currentWeatherStatus = currentWeather["condition"]["text"];
        weatherText = Constants.getWeatherText(currentWeatherStatus);
        temperature = currentWeather["temp_c"].toInt();
        windSpeed = currentWeather["wind_kph"].toInt();
        humidity = currentWeather["humidity"].toInt();
        cloud = currentWeather["cloud"].toInt();

        // Forecast Data
        dailyWeatherForecast = weatherData["forecast"]["forecastday"];
        hourlyWeatherForecast = dailyWeatherForecast[0]["hour"];
        print(dailyWeatherForecast); // Debug print
      });
    } catch (e) {
      print('Error fetching weather data: $e'); // Error handling
    }
  }

  // Function to return the first two names of string location
  static String getShortLocationName(String s) {
    List<String> wordList = s.split(" ");
    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return wordList[0] + " " + wordList[1];
      } else {
        return wordList[0];
      }
    } else {
      return " ";
    }
  }

  @override
  void initState() {
    fetchWeatherData(location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.only(top: 60, left: 10, right: 10),
        color: _constants.primaryColor.withOpacity(.1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: size.height * .87,
                decoration: BoxDecoration(
                  gradient: _constants.linearGradientBlue,
                  boxShadow: [
                    BoxShadow(
                      color: _constants.primaryColor.withOpacity(.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/642000.png",
                          width: 40,
                          height: 40,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/pin.png",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              location,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _cityController.clear();
                                showMaterialModalBottomSheet(
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                    controller:
                                    ModalScrollController.of(context),
                                    child: Container(
                                      height: size.height + .2,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 20,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 70,
                                            child: Divider(
                                              thickness: 3.5,
                                              color: _constants.primaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          TextField(
                                            onSubmitted: (searchText) {
                                              fetchWeatherData(searchText);
                                              Navigator.pop(
                                                  context); // Close the modal after search
                                            },
                                            controller: _cityController,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.search,
                                                color: _constants.primaryColor,
                                              ),
                                              suffixIcon: GestureDetector(
                                                onTap: () =>
                                                    _cityController.clear(),
                                                child: Icon(
                                                  Icons.close,
                                                  color:
                                                  _constants.primaryColor,
                                                ),
                                              ),
                                              hintText:
                                              'Search city e.g. Haripur',
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                  _constants.primaryColor,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/icon.png",
                            width: 30,
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 180,
                      child: Center(
                        child: Text(
                          weatherText,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            temperature.toString(),
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = _constants.shader,
                            ),
                          ),
                        ),
                        Text(
                          'o',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = _constants.shader,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        currentWeatherStatus,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 23.0,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        currentDate,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Divider(
                        color: Colors.white70,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Weatheritem(
                            text: 'windSpeed',
                            value: windSpeed.toInt(),
                            unit: 'km/h',
                            imageUrl: 'assets/wingsign.jpeg',
                          ),
                          Weatheritem(
                            text: 'humidity',
                            value: humidity.toInt(),
                            unit: '%',
                            imageUrl: 'assets/2322701.png',
                          ),
                          Weatheritem(
                            text: 'chance of Rain',
                            value: cloud.toInt(),
                            unit: '%',
                            imageUrl: 'assets/cloudy.png',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => detailPage(
                            dailyForecastWeather: dailyWeatherForecast,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        // Adjust padding as needed
                        child: Text(
                          'forecasts',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: _constants.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    SizedBox(
    height: 150,
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: hourlyWeatherForecast.length,
    itemBuilder: (BuildContext context, int index) {
    String currentTime = hourlyWeatherForecast[index]["time"];
    String currentHour = currentTime.substring(11, 13);
    String currentMin = currentTime.substring(14, 16);

    String systemTime = DateFormat('HH:mm').format(DateTime.now());

    return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    margin: const EdgeInsets.only(right: 20),
    width: 110,
    decoration: BoxDecoration(
    color: currentHour == systemTime.substring(0, 2) &&
    currentMin == systemTime.substring(3, 5)
    ? Colors.blue
        : _constants.primaryColor,
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    boxShadow: [
    BoxShadow(
    offset: const Offset(0, 1),
    blurRadius: 5,
    color: _constants.primaryColor.withOpacity(.2),
    ),
    ],
    ),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Text(
    DateFormat('HH:mm').format(DateTime.parse(currentTime)),
    style: const TextStyle(
    fontSize: 16,
    color: Colors.white,
    ),
    ),
    Text(
    Constants.getWeatherText(
    hourlyWeatherForecast[index]["condition"]["text"]),
    style: const TextStyle(
    fontSize: 15,
    color: Colors.white,
    ),
    ),
    Text(
    '${hourlyWeatherForecast[index]["temp_c"].round()}°',
    style: const TextStyle(
    fontSize: 16,
    color: Colors.white,
     ),
     ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
