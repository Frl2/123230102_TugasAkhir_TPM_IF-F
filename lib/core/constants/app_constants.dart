class AppConstants {
  // App Info
  static const String appName = 'UrbanSafe';
  static const String appVersion = '1.0.0';

  // API Endpoints
  static const String baseUrl = 'https://api.urbansafe.id/v1';
  static const String krlApiUrl = 'https://api.commuterline.id/v1';
  static const String mrtApiUrl = 'https://api.jakartamrt.co.id/val/stasiuns';
  static const String transjakartaUrl = 'https://apilangsungaja.id/transjakarta/v2';
  static const String exchangeRateUrl = 'https://api.exchangerate-api.com/v4/latest/IDR';
  static const String openAiUrl = 'https://api.openai.com/v1/chat/completions';

  // API Keys (gunakan env / secure config di produksi)
  static const String exchangeRateApiKey = 'YOUR_EXCHANGE_RATE_KEY';
  static const String openAiApiKey = 'YOUR_OPENAI_API_KEY';
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_KEY';

  // Secure Storage Keys
  static const String keySessionToken = 'session_token';
  static const String keyUserId = 'user_id';
  static const String keyBiometricEnabled = 'biometric_enabled';
  static const String keyPasswordHash = 'password_hash';

  // Hive Box Names
  static const String hiveBoxSettings = 'settings_box';
  static const String hiveBoxCache = 'cache_box';
  static const String hiveBoxSchedule = 'schedule_box';

  // Sensor Thresholds
  static const double accelCrashThreshold = 20.0; // m/s² - deteksi benturan keras
  static const double accelFallThreshold = 15.0;  // m/s² - deteksi jatuh

  // Session
  static const int sessionDurationHours = 24;
  static const int sessionRefreshMinutes = 30;

  // Transport Types
  static const String transportKRL = 'KRL';
  static const String transportMRT = 'MRT';
  static const String transportLRT = 'LRT';
  static const String transportBusway = 'Busway';

  // Crowd Level Labels
  static const Map<int, String> crowdLabels = {
    1: 'Sangat Sepi',
    2: 'Sepi',
    3: 'Normal',
    4: 'Padat',
    5: 'Sangat Padat',
  };

  // Time Zones
  static const Map<String, int> timeZones = {
    'WIB': 7,    // UTC+7 (Jakarta, Jawa, Sumatra)
    'WITA': 8,   // UTC+8 (Bali, NTT, Kalimantan Tengah)
    'WIT': 9,    // UTC+9 (Papua, Maluku)
    'London': 0, // UTC+0 (atau +1 saat BST)
  };

  // Currencies
  static const List<Map<String, String>> currencies = [
    {'code': 'IDR', 'name': 'Rupiah', 'symbol': 'Rp'},
    {'code': 'USD', 'name': 'Dolar Amerika', 'symbol': '\$'},
    {'code': 'EUR', 'name': 'Euro', 'symbol': '€'},
    {'code': 'JPY', 'name': 'Yen Jepang', 'symbol': '¥'},
    {'code': 'SGD', 'name': 'Dolar Singapura', 'symbol': 'S\$'},
    {'code': 'MYR', 'name': 'Ringgit Malaysia', 'symbol': 'RM'},
    {'code': 'GBP', 'name': 'Pound Sterling', 'symbol': '£'},
  ];

  // Mini Game
  static const int gameLevels = 5;
  static const int gameTimerSeconds = 60;
  static const int gameBaseScore = 100;
}
