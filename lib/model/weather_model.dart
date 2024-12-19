class WeatherModel {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  WeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherModel.maptoModal(Map m1) {
    return WeatherModel(
      id: m1["id"],
      base: m1["base"],
      clouds: Clouds.mapToModal(m1["clouds"]),
      cod: m1["cod"],
      coord: Coord.mapToModal(m1["coord"]),
      dt: m1["dt"],
      main: Main.mapToModal(m1["main"]),
      name: m1["name"],
      sys: Sys.mapToModal(m1["sys"]),
      timezone: m1["timezone"],
      visibility: m1["visibility"],
      weather:
          List<Weather>.from(m1['weather'].map((e) => Weather.mapToModal(e))),
      wind: Wind.mapToModal(m1['wind']),
    );
  }
}

class Clouds {
  int? all;

  Clouds({
    this.all,
  });

  factory Clouds.mapToModal(Map m1) {
    return Clouds(
      all: m1["all"],
    );
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord({
    this.lon,
    this.lat,
  });
  factory Coord.mapToModal(Map m1) {
    return Coord(
      lat: m1["lat"],
      lon: m1["lon"],
    );
  }
}

class Main {
  double? temp;
  double? feels_like;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  Main({
    this.temp,
    this.feels_like,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory Main.mapToModal(Map m1) {
    return Main(
      grndLevel: m1["grnd_level"],
      humidity: m1["humidity"],
      pressure: m1["pressure"],
      feels_like: m1['feels_like'],
      seaLevel: m1["sea_level"],
      temp: m1["temp"],
      tempMax: m1["temp_max"],
      tempMin: m1["temp_min"],
    );
  }
}

class Sys {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });
  factory Sys.mapToModal(Map m1) {
    return Sys(
      country: m1["country"],
      id: m1["id"],
      sunrise: m1["sunrise"],
      sunset: m1["sunset"],
      type: m1["type"],
    );
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });
  factory Weather.mapToModal(Map m1) {
    return Weather(
      description: m1["description"],
      icon: m1["icon"],
      id: m1["id"],
      main: m1["main"],
    );
  }
}

class Wind {
  double? speed;
  int? deg;

  Wind({
    this.speed,
    this.deg,
  });

  factory Wind.mapToModal(Map m1) {
    return Wind(
      deg: m1["deg"],
      speed: m1["speed"],
    );
  }
}
