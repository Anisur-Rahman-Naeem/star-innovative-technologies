class DashboardResponseModel {
  String? status;
  int? code;
  Data? data;

  DashboardResponseModel({this.status, this.code, this.data});

  DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    code = json['code'] as int?;
    data = json['data'] != null ? Data.fromJson(Map<String, dynamic>.from(json['data'] as Map)) : null;
  }
}

class Data {
  String? status;
  Location? location;
  Method? method;
  AsrJuristicMethod? asrJuristicMethod;
  Date? date;
  Timings? timings;
  NextPrayer? nextPrayer;
  DailyGoal? dailyGoal;
  Streak? streak;
  AiReflection? aiReflection;
  AbundanceVerse? abundanceVerse;

  Data({
    this.status,
    this.location,
    this.method,
    this.asrJuristicMethod,
    this.date,
    this.timings,
    this.nextPrayer,
    this.dailyGoal,
    this.streak,
    this.aiReflection,
    this.abundanceVerse,
  });

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    location = json['location'] != null ? Location.fromJson(Map<String, dynamic>.from(json['location'] as Map)) : null;
    method = json['method'] != null ? Method.fromJson(Map<String, dynamic>.from(json['method'] as Map)) : null;
    asrJuristicMethod = json['asr_juristic_method'] != null
        ? AsrJuristicMethod.fromJson(Map<String, dynamic>.from(json['asr_juristic_method'] as Map))
        : null;
    date = json['date'] != null ? Date.fromJson(Map<String, dynamic>.from(json['date'] as Map)) : null;
    timings = json['timings'] != null ? Timings.fromJson(Map<String, dynamic>.from(json['timings'] as Map)) : null;
    nextPrayer = json['next_prayer'] != null ? NextPrayer.fromJson(Map<String, dynamic>.from(json['next_prayer'] as Map)) : null;
    dailyGoal = json['daily_goal'] != null ? DailyGoal.fromJson(Map<String, dynamic>.from(json['daily_goal'] as Map)) : null;
    streak = json['streak'] != null ? Streak.fromJson(Map<String, dynamic>.from(json['streak'] as Map)) : null;
    aiReflection = json['ai_reflection'] != null ? AiReflection.fromJson(Map<String, dynamic>.from(json['ai_reflection'] as Map)) : null;
    abundanceVerse = json['abundance_verse'] != null
        ? AbundanceVerse.fromJson(Map<String, dynamic>.from(json['abundance_verse'] as Map))
        : null;
  }
}

class Location {
  String? latitude;
  String? longitude;
  String? address;
  String? city;
  String? countryCode;
  String? timezone;

  Location({
    this.latitude,
    this.longitude,
    this.address,
    this.city,
    this.countryCode,
    this.timezone,
  });

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude']?.toString();
    longitude = json['longitude']?.toString();
    address = json['address']?.toString();
    city = json['city']?.toString();
    countryCode = json['country_code']?.toString();
    timezone = json['timezone']?.toString();
  }
}

class Method {
  int? id;
  String? name;

  Method({this.id, this.name});

  Method.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name']?.toString();
  }
}

class AsrJuristicMethod {
  int? id;
  String? key;
  String? name;
  String? description;

  AsrJuristicMethod({this.id, this.key, this.name, this.description});

  AsrJuristicMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    key = json['key']?.toString();
    name = json['name']?.toString();
    description = json['description']?.toString();
  }
}

class Date {
  Gregorian? gregorian;
  Hijri? hijri;

  Date({this.gregorian, this.hijri});

  Date.fromJson(Map<String, dynamic> json) {
    gregorian = json['gregorian'] != null ? Gregorian.fromJson(Map<String, dynamic>.from(json['gregorian'] as Map)) : null;
    hijri = json['hijri'] != null ? Hijri.fromJson(Map<String, dynamic>.from(json['hijri'] as Map)) : null;
  }
}

class Gregorian {
  String? date;
  String? weekdayEn;

  Gregorian({this.date, this.weekdayEn});

  Gregorian.fromJson(Map<String, dynamic> json) {
    date = json['date']?.toString();
    weekdayEn = json['weekday_en']?.toString();
  }
}

class Hijri {
  String? date;
  int? day;
  String? monthEn;
  int? year;

  Hijri({this.date, this.day, this.monthEn, this.year});

  Hijri.fromJson(Map<String, dynamic> json) {
    date = json['date']?.toString();
    day = json['day'] as int?;
    monthEn = json['month_en']?.toString();
    year = json['year'] as int?;
  }
}

class Timings {
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? maghrib;
  String? isha;

  Timings({
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.maghrib,
    this.isha,
  });

  Timings.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr']?.toString();
    sunrise = json['Sunrise']?.toString();
    dhuhr = json['Dhuhr']?.toString();
    asr = json['Asr']?.toString();
    maghrib = json['Maghrib']?.toString();
    isha = json['Isha']?.toString();
  }
}

class NextPrayer {
  String? name;
  String? at;
  int? secondsUntil;

  NextPrayer({this.name, this.at, this.secondsUntil});

  NextPrayer.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    at = json['at']?.toString();
    secondsUntil = json['seconds_until'] as int?;
  }
}

class DailyGoal {
  int? completed;
  int? target;

  DailyGoal({this.completed, this.target});

  DailyGoal.fromJson(Map<String, dynamic> json) {
    completed = json['completed'] as int?;
    target = json['target'] as int?;
  }
}

class Streak {
  int? current;
  int? longest;
  bool? countedToday;
  String? lastCountedDate;

  Streak({this.current, this.longest, this.countedToday, this.lastCountedDate});

  Streak.fromJson(Map<String, dynamic> json) {
    current = json['current'] as int?;
    longest = json['longest'] as int?;
    countedToday = json['counted_today'] as bool?;
    lastCountedDate = json['last_counted_date']?.toString();
  }
}

class AiReflection {
  String? text;
  String? source;
  String? forDate;

  AiReflection({this.text, this.source, this.forDate});

  AiReflection.fromJson(Map<String, dynamic> json) {
    text = json['text']?.toString();
    source = json['source']?.toString();
    forDate = json['for_date']?.toString();
  }
}

class AbundanceVerse {
  String? kind;
  String? arabic;
  String? translation;
  String? reference;

  AbundanceVerse({this.kind, this.arabic, this.translation, this.reference});

  AbundanceVerse.fromJson(Map<String, dynamic> json) {
    kind = json['kind']?.toString();
    arabic = json['arabic']?.toString();
    translation = json['translation']?.toString();
    reference = json['reference']?.toString();
  }
}
