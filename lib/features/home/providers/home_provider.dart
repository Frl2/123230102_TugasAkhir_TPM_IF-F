import 'package:flutter_riverpod/flutter_riverpod.dart';

// ============================================================
// DATA MODELS
// ============================================================

class StationModel {
  final String id;
  final String name;
  final String transportType;
  final double latitude;
  final double longitude;
  final double? distanceKm;

  const StationModel({
    required this.id,
    required this.name,
    required this.transportType,
    required this.latitude,
    required this.longitude,
    this.distanceKm,
  });
}

class ScheduleModel {
  final String id;
  final String trainName;
  final String origin;
  final String destination;
  final String departureTime;
  final String platform;
  final String transportType;
  final int crowdLevel;
  final String status; // 'on_time', 'delayed', 'cancelled'
  final int delayMinutes;

  const ScheduleModel({
    required this.id,
    required this.trainName,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.platform,
    required this.transportType,
    required this.crowdLevel,
    required this.status,
    this.delayMinutes = 0,
  });
}

class CrowdPrediction {
  final String stationName;
  final int level; // 1-5
  final String transportType;
  final String predictedTime;

  const CrowdPrediction({
    required this.stationName,
    required this.level,
    required this.transportType,
    required this.predictedTime,
  });
}

class HomeState {
  final List<StationModel> nearbyStations;
  final List<ScheduleModel> schedules;
  final List<CrowdPrediction> crowdPredictions;
  final String? selectedTransport;
  final bool isLoading;
  final String? error;

  const HomeState({
    this.nearbyStations = const [],
    this.schedules = const [],
    this.crowdPredictions = const [],
    this.selectedTransport,
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    List<StationModel>? nearbyStations,
    List<ScheduleModel>? schedules,
    List<CrowdPrediction>? crowdPredictions,
    String? selectedTransport,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      nearbyStations: nearbyStations ?? this.nearbyStations,
      schedules: schedules ?? this.schedules,
      crowdPredictions: crowdPredictions ?? this.crowdPredictions,
      selectedTransport: selectedTransport ?? this.selectedTransport,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// ============================================================
// PROVIDER
// ============================================================

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() => const HomeState();

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      await Future.wait([
        _loadNearbyStations(),
        _loadSchedules(),
        _loadCrowdPredictions(),
      ]);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> _loadNearbyStations() async {
    // Simulasi data stasiun terdekat (Jakarta)
    // Di produksi: panggil API MRT/KRL untuk stasiun terdekat
    await Future.delayed(const Duration(milliseconds: 300));
    state = state.copyWith(
      nearbyStations: [
        const StationModel(
          id: 'bni_city',
          name: 'BNI City (Sudirman)',
          transportType: 'KRL',
          latitude: -6.2009,
          longitude: 106.8228,
          distanceKm: 0.3,
        ),
        const StationModel(
          id: 'dukuh_atas',
          name: 'Dukuh Atas',
          transportType: 'MRT',
          latitude: -6.2013,
          longitude: 106.8232,
          distanceKm: 0.4,
        ),
        const StationModel(
          id: 'halte_harmoni',
          name: 'Halte Harmoni',
          transportType: 'Busway',
          latitude: -6.1655,
          longitude: 106.8161,
          distanceKm: 0.7,
        ),
      ],
      isLoading: false,
    );
  }

  Future<void> _loadSchedules() async {
    // Simulasi jadwal KRL Commuter Line
    // Di produksi: panggil API KAI Commuter
    final now = DateTime.now();
    final minutes1 = now.add(const Duration(minutes: 5));
    final minutes2 = now.add(const Duration(minutes: 12));
    final minutes3 = now.add(const Duration(minutes: 23));

    String fmt(DateTime dt) =>
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

    state = state.copyWith(
      schedules: [
        ScheduleModel(
          id: '1',
          trainName: 'KRL Bogor - Kota',
          origin: 'Bogor',
          destination: 'Kota',
          departureTime: fmt(minutes1),
          platform: 'Peron 3',
          transportType: 'KRL',
          crowdLevel: 4,
          status: 'on_time',
        ),
        ScheduleModel(
          id: '2',
          trainName: 'MRT Lebak Bulus - Bundaran HI',
          origin: 'Lebak Bulus',
          destination: 'Bundaran HI',
          departureTime: fmt(minutes2),
          platform: 'Platform 1',
          transportType: 'MRT',
          crowdLevel: 2,
          status: 'on_time',
        ),
        ScheduleModel(
          id: '3',
          trainName: 'KRL Bekasi - Kota',
          origin: 'Bekasi',
          destination: 'Kota',
          departureTime: fmt(minutes3),
          platform: 'Peron 1',
          transportType: 'KRL',
          crowdLevel: 5,
          status: 'delayed',
          delayMinutes: 8,
        ),
      ],
    );
  }

  Future<void> _loadCrowdPredictions() async {
    // Simulasi prediksi kepadatan dari model ML (TFLite)
    // Di produksi: inferensi dengan model crowd_prediction.tflite
    state = state.copyWith(
      crowdPredictions: [
        const CrowdPrediction(
          stationName: 'Sudirman (KRL)',
          level: 5,
          transportType: 'KRL',
          predictedTime: '07:30 - 09:00',
        ),
        const CrowdPrediction(
          stationName: 'Dukuh Atas (MRT)',
          level: 3,
          transportType: 'MRT',
          predictedTime: 'Sekarang',
        ),
        const CrowdPrediction(
          stationName: 'Harmoni (Busway)',
          level: 4,
          transportType: 'Busway',
          predictedTime: 'Sekarang',
        ),
      ],
    );
  }

  void filterTransport(String type) {
    state = state.copyWith(selectedTransport: type);
    // Filter schedules berdasarkan tipe transport
  }
}

final homeProvider = NotifierProvider<HomeNotifier, HomeState>(HomeNotifier.new);
