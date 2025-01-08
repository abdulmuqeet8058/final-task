class WeatherModel {
  final double currentTemperature;
  final String weatherDescription;
  final String cityName;

  WeatherModel({
    required this.currentTemperature,
    required this.weatherDescription,
    required this.cityName,
  });

  // Factory method to create WeatherModel from JSON
  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        currentTemperature: json['main']['temp']?.toDouble() ?? 0.0,
        weatherDescription: json['weather']?[0]?['description'] ?? 'Unknown',
        cityName: json['name'] ?? 'Unknown City',
      );

  // Method to convert WeatherModel to JSON (optional, if needed)
  Map<String, dynamic> toJson() => {
        "Current temperature": currentTemperature,
        "Weather description": weatherDescription,
        "City name": cityName,
      };
}
