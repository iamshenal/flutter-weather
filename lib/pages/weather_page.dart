import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:weather_app/models/weather_models.dart";
import "package:weather_app/services/weather_service.dart";

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('c15e69cbf3c87ac651ec9af346a38ce2');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // to catch errors
    catch (e) {
      print(e);
    }
  }

  // weather animation
  String getWeatherAnimation(String? mainCondtitoin) {
    if (mainCondtitoin == null) return 'assets/sunny.json';

    switch (mainCondtitoin.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/clouds.json';

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';

      case 'thunderstorm':
        return 'assets/thunder.json';

      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // initial state
  @override
  void initState() {
    // implementing initState
    super.initState();

    // fetching weather on startup of the app
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        backgroundColor: Colors.white24,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? "Loading City"),

            // animations
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // temperature
            Text("${_weather?.temperature.round()}°C"),

            // weather condition
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}
