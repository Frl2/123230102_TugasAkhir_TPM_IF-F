import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/app_constants.dart';

// ============================================================
// MODELS
// ============================================================

class RouteModel {
  final String id;
  final String origin;
  final String destination;
  final List<String> transportModes;
  final int estimatedMinutes;
  final double fareIdr;
  final double crowdScore;
  final int transfers;
  final List<RouteStep> steps;

  const RouteModel({
    required this.id,
    required this.origin,
    required this.destination,
    required this.transportModes,
    required this.estimatedMinutes,
    required this.fareIdr,
    required this.crowdScore,
    required this.transfers,
    required this.steps,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'origin': origin,
    'destination': destination,
    'transportModes': transportModes,
    'estimatedMinutes': estimatedMinutes,
    'fareIdr': fareIdr,
    'crowdScore': crowdScore,
    'transfers': transfers,
  };
}

class RouteStep {
  final String instruction;
  final String transportType;
  final String fromStation;
  final String toStation;
  final int durationMinutes;

  const RouteStep({
    required this.instruction,
    required this.transportType,
    required this.fromStation,
    required this.toStation,
    required this.durationMinutes,
  });
}

// ============================================================
// STATE
// ============================================================

class RouteState {
  final List<RouteModel> routes;
  final List<Map<String, dynamic>> favoriteRoutes;
  final List<Map<String, String>> llmMessages;
  final bool isLoading;
  final bool isLlmLoading;
  final String? error;

  const RouteState({
    this.routes = const [],
    this.favoriteRoutes = const [],
    this.llmMessages = const [],
    this.isLoading = false,
    this.isLlmLoading = false,
    this.error,
  });

  RouteState copyWith({
    List<RouteModel>? routes,
    List<Map<String, dynamic>>? favoriteRoutes,
    List<Map<String, String>>? llmMessages,
    bool? isLoading,
    bool? isLlmLoading,
    String? error,
  }) => RouteState(
    routes: routes ?? this.routes,
    favoriteRoutes: favoriteRoutes ?? this.favoriteRoutes,
    llmMessages: llmMessages ?? this.llmMessages,
    isLoading: isLoading ?? this.isLoading,
    isLlmLoading: isLlmLoading ?? this.isLlmLoading,
    error: error,
  );
}

// ============================================================
// NOTIFIER
// ============================================================

class RouteNotifier extends Notifier<RouteState> {
  final Dio _dio = Dio();

  @override
  RouteState build() => const RouteState();

  /// Cari rute dengan kalkulasi kepadatan dari ML
  Future<void> searchRoute({
    required String origin,
    required String destination,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulasi API call

      // Di produksi: panggil API transportasi + model ML untuk crowd score
      // lalu urutkan berdasarkan (waktu * crowd_weight)
      final routes = _generateMockRoutes(origin, destination);
      state = state.copyWith(routes: routes, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Tanya LLM untuk rute alternatif saat gangguan
  Future<void> askLlmAssistant(String question) async {
    final messages = List<Map<String, String>>.from(state.llmMessages)
      ..add({'role': 'user', 'content': question});

    state = state.copyWith(
      llmMessages: messages,
      isLlmLoading: true,
    );

    try {
      // Panggil OpenAI / Gemini API
      final response = await _dio.post(
        AppConstants.openAiUrl,
        options: Options(headers: {
          'Authorization': 'Bearer ${AppConstants.openAiApiKey}',
          'Content-Type': 'application/json',
        }),
        data: {
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content':
                  'Kamu adalah asisten navigasi transportasi publik Jakarta. '
                  'Bantu pengguna mencari rute alternatif KRL, MRT, LRT, dan Busway. '
                  'Jawab dalam Bahasa Indonesia, singkat dan informatif.',
            },
            ...messages.map((m) => {'role': m['role'], 'content': m['content']}),
          ],
          'max_tokens': 300,
          'temperature': 0.7,
        },
      );

      final reply = response.data['choices'][0]['message']['content'] as String;
      final updated = List<Map<String, String>>.from(state.llmMessages)
        ..add({'role': 'assistant', 'content': reply});

      state = state.copyWith(llmMessages: updated, isLlmLoading: false);
    } catch (e) {
      // Fallback response jika API error
      final updated = List<Map<String, String>>.from(state.llmMessages)
        ..add({
          'role': 'assistant',
          'content':
              'Maaf, saya tidak dapat terhubung ke server saat ini. '
              'Coba rute alternatif: gunakan Busway TransJakarta koridor 1 '
              'atau MRT dari stasiun terdekat.',
        });
      state = state.copyWith(llmMessages: updated, isLlmLoading: false);
    }
  }

  /// Generate mock routes (simulasi hasil API + ML)
  List<RouteModel> _generateMockRoutes(String origin, String destination) {
    return [
      RouteModel(
        id: 'r1',
        origin: origin,
        destination: destination,
        transportModes: ['KRL', 'Jalan Kaki'],
        estimatedMinutes: 35,
        fareIdr: 4000,
        crowdScore: 3.2,
        transfers: 0,
        steps: [
          RouteStep(
            instruction: 'Naik KRL tujuan Kota',
            transportType: 'KRL',
            fromStation: origin,
            toStation: 'Gambir',
            durationMinutes: 28,
          ),
          RouteStep(
            instruction: 'Jalan kaki ke tujuan',
            transportType: 'Jalan Kaki',
            fromStation: 'Gambir',
            toStation: destination,
            durationMinutes: 7,
          ),
        ],
      ),
      RouteModel(
        id: 'r2',
        origin: origin,
        destination: destination,
        transportModes: ['MRT', 'KRL'],
        estimatedMinutes: 42,
        fareIdr: 8500,
        crowdScore: 1.8,
        transfers: 1,
        steps: [
          RouteStep(
            instruction: 'Naik MRT arah Bundaran HI',
            transportType: 'MRT',
            fromStation: origin,
            toStation: 'Dukuh Atas',
            durationMinutes: 15,
          ),
          RouteStep(
            instruction: 'Pindah ke KRL di Sudirman',
            transportType: 'KRL',
            fromStation: 'Sudirman',
            toStation: destination,
            durationMinutes: 27,
          ),
        ],
      ),
      RouteModel(
        id: 'r3',
        origin: origin,
        destination: destination,
        transportModes: ['Busway', 'MRT'],
        estimatedMinutes: 55,
        fareIdr: 6500,
        crowdScore: 2.5,
        transfers: 1,
        steps: [
          RouteStep(
            instruction: 'Naik Busway koridor 1',
            transportType: 'Busway',
            fromStation: origin,
            toStation: 'Harmoni',
            durationMinutes: 30,
          ),
          RouteStep(
            instruction: 'Transit ke MRT',
            transportType: 'MRT',
            fromStation: 'Harmoni',
            toStation: destination,
            durationMinutes: 25,
          ),
        ],
      ),
    ];
  }
}

final routeProvider =
    NotifierProvider<RouteNotifier, RouteState>(RouteNotifier.new);
