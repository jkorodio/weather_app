class ResponseEntity {
  ResponseEntity({
    this.location,
    this.current,
    this.forecast,
  });

  LocationEntity? location;
  CurrentEntity? current;
  ForecastEntity? forecast;
}

class SearchEntity {
  SearchEntity({
    this.name,
    this.region,
    this.country,
  });

  String? name;
  String? region;
  String? country;
}

class ForecastEntity {
  ForecastEntity({
    this.forecastday,
  });

  List<ForecastEntityday>? forecastday;
}

class ForecastEntityday {
  ForecastEntityday({
    this.date,
    this.dateEpoch,
    this.day,
    this.astro,
    this.hour,
  });

  String? date;
  num? dateEpoch;
  DayEntity? day;
  AstroEntity? astro;
  List<HourEntity>? hour;
}

class HourEntity {
  HourEntity({
    this.timeEpoch,
    this.time,
    this.tempC,
    this.tempF,
    this.isDayEntity,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.snowCm,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.windchillC,
    this.windchillF,
    this.heatindexC,
    this.heatindexF,
    this.dewpointC,
    this.dewpointF,
    this.willItRain,
    this.chanceOfRain,
    this.willItSnow,
    this.chanceOfSnow,
    this.visKm,
    this.visMiles,
    this.gustMph,
    this.gustKph,
    this.uv,
  });

  num? timeEpoch;
  String? time;
  num? tempC;
  num? tempF;
  num? isDayEntity;
  ConditionEntity? condition;
  num? windMph;
  num? windKph;
  num? windDegree;
  String? windDir;
  num? pressureMb;
  num? pressureIn;
  num? precipMm;
  num? precipIn;
  num? snowCm;
  num? humidity;
  num? cloud;
  num? feelslikeC;
  num? feelslikeF;
  num? windchillC;
  num? windchillF;
  num? heatindexC;
  num? heatindexF;
  num? dewpointC;
  num? dewpointF;
  num? willItRain;
  num? chanceOfRain;
  num? willItSnow;
  num? chanceOfSnow;
  num? visKm;
  num? visMiles;
  num? gustMph;
  num? gustKph;
  num? uv;
}

class ConditionEntity {
  ConditionEntity({
    this.text,
    this.icon,
    this.code,
  });

  String? text;
  String? icon;
  num? code;
}

class AstroEntity {
  AstroEntity({
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.moonIllumination,
    this.isMoonUp,
    this.isSunUp,
  });

  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? moonPhase;
  num? moonIllumination;
  num? isMoonUp;
  num? isSunUp;
}

class DayEntity {
  DayEntity({
    this.maxtempC,
    this.maxtempF,
    this.mintempC,
    this.mintempF,
    this.avgtempC,
    this.avgtempF,
    this.maxwindMph,
    this.maxwindKph,
    this.totalprecipMm,
    this.totalprecipIn,
    this.totalsnowCm,
    this.avgvisKm,
    this.avgvisMiles,
    this.avghumidity,
    this.dailyWillItRain,
    this.dailyChanceOfRain,
    this.dailyWillItSnow,
    this.dailyChanceOfSnow,
    this.condition,
    this.uv,
  });

  num? maxtempC;
  num? maxtempF;
  num? mintempC;
  num? mintempF;
  num? avgtempC;
  num? avgtempF;
  num? maxwindMph;
  num? maxwindKph;
  num? totalprecipMm;
  num? totalprecipIn;
  num? totalsnowCm;
  num? avgvisKm;
  num? avgvisMiles;
  num? avghumidity;
  num? dailyWillItRain;
  num? dailyChanceOfRain;
  num? dailyWillItSnow;
  num? dailyChanceOfSnow;
  ConditionEntity? condition;
  num? uv;
}

class CurrentEntity {
  CurrentEntity({
    this.lastUpdatedEpoch,
    this.lastUpdated,
    this.tempC,
    this.tempF,
    this.isDayEntity,
    this.condition,
    this.windMph,
    this.windKph,
    this.windDegree,
    this.windDir,
    this.pressureMb,
    this.pressureIn,
    this.precipMm,
    this.precipIn,
    this.humidity,
    this.cloud,
    this.feelslikeC,
    this.feelslikeF,
    this.windchillC,
    this.windchillF,
    this.heatindexC,
    this.heatindexF,
    this.dewpointC,
    this.dewpointF,
    this.visKm,
    this.visMiles,
    this.uv,
    this.gustMph,
    this.gustKph,
  });

  num? lastUpdatedEpoch;
  String? lastUpdated;
  num? tempC;
  num? tempF;
  num? isDayEntity;
  ConditionEntity? condition;
  num? windMph;
  num? windKph;
  num? windDegree;
  String? windDir;
  num? pressureMb;
  num? pressureIn;
  num? precipMm;
  num? precipIn;
  num? humidity;
  num? cloud;
  num? feelslikeC;
  num? feelslikeF;
  num? windchillC;
  num? windchillF;
  num? heatindexC;
  num? heatindexF;
  num? dewpointC;
  num? dewpointF;
  num? visKm;
  num? visMiles;
  num? uv;
  num? gustMph;
  num? gustKph;
}

class LocationEntity {
  LocationEntity({
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.tzId,
    this.localtimeEpoch,
    this.localtime,
  });

  String? name;
  String? region;
  String? country;
  num? lat;
  num? lon;
  String? tzId;
  num? localtimeEpoch;
  String? localtime;
}
