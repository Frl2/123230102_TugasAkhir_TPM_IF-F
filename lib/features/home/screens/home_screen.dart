import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../features/auth/providers/auth_provider.dart';
import '../providers/home_provider.dart';
import '../widgets/schedule_card.dart';
import '../widgets/crowd_indicator.dart';
import '../widgets/quick_action_button.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  bool _mapLoaded = false;

  @override
  void initState() {
    super.initState();
    _requestLocation();
    // Muat jadwal dan crowd data
    Future.microtask(() {
      ref.read(homeProvider.notifier).loadData();
    });
  }

  Future<void> _requestLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (mounted) setState(() => _currentPosition = position);

      // Update map camera
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md, AppSpacing.md, AppSpacing.md, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat datang,',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            user?.fullName ?? user?.username ?? 'Pengguna',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                    // Notif button
                    IconButton(
                      onPressed: () => context.push(AppRoutes.notifications),
                      icon: const Badge(
                        label: Text('3'),
                        child: Icon(Icons.notifications_outlined),
                      ),
                    ),
                    // Sensor button
                    IconButton(
                      onPressed: () => context.push(AppRoutes.sensorMonitor),
                      icon: const Icon(Icons.sensors_rounded),
                      tooltip: 'Monitor Sensor',
                    ),
                  ],
                ),
              ),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: GestureDetector(
                  onTap: () => context.go(AppRoutes.routes),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).inputDecorationTheme.fillColor,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: Theme.of(context).dividerColor.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded,
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color),
                        const SizedBox(width: 12),
                        Text(
                          'Cari stasiun atau rute...',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        Icon(Icons.tune_rounded,
                            size: 20,
                            color: AppTheme.primaryBlue),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Quick Actions
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Row(
                  children: [
                    Expanded(
                      child: QuickActionButton(
                        icon: Icons.train_rounded,
                        label: 'KRL',
                        color: AppTheme.primaryBlue,
                        onTap: () => ref
                            .read(homeProvider.notifier)
                            .filterTransport(AppConstants.transportKRL),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: QuickActionButton(
                        icon: Icons.subway_rounded,
                        label: 'MRT',
                        color: AppTheme.accentTeal,
                        onTap: () => ref
                            .read(homeProvider.notifier)
                            .filterTransport(AppConstants.transportMRT),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: QuickActionButton(
                        icon: Icons.directions_bus_rounded,
                        label: 'Busway',
                        color: AppTheme.warningAmber,
                        onTap: () => ref
                            .read(homeProvider.notifier)
                            .filterTransport(AppConstants.transportBusway),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: QuickActionButton(
                        icon: Icons.sports_esports_rounded,
                        label: 'Game',
                        color: AppTheme.dangerCoral,
                        onTap: () => context.push(AppRoutes.game),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

            // Peta LBS
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Peta Stasiun Terdekat',
                            style: Theme.of(context).textTheme.titleLarge),
                        TextButton.icon(
                          onPressed: _requestLocation,
                          icon: const Icon(Icons.my_location_rounded, size: 16),
                          label: const Text('Lokasi Saya'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      child: SizedBox(
                        height: 200,
                        child: Stack(
                          children: [
                            GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: _currentPosition != null
                                    ? LatLng(_currentPosition!.latitude,
                                        _currentPosition!.longitude)
                                    : const LatLng(-6.2088, 106.8456), // Jakarta default
                                zoom: 14,
                              ),
                              onMapCreated: (controller) {
                                _mapController = controller;
                                setState(() => _mapLoaded = true);
                              },
                              myLocationEnabled: true,
                              myLocationButtonEnabled: false,
                              zoomControlsEnabled: false,
                              markers: homeState.nearbyStations
                                  .map((s) => Marker(
                                        markerId: MarkerId(s.id),
                                        position:
                                            LatLng(s.latitude, s.longitude),
                                        infoWindow: InfoWindow(
                                          title: s.name,
                                          snippet: s.transportType,
                                        ),
                                      ))
                                  .toSet(),
                            ),
                            if (!_mapLoaded)
                              Container(
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

            // Prediksi Kepadatan (ML)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Prediksi Kepadatan',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.auto_awesome_rounded,
                                  size: 12, color: AppTheme.primaryBlue),
                              const SizedBox(width: 4),
                              Text('ML',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppTheme.primaryBlue,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (homeState.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      Column(
                        children: homeState.crowdPredictions
                            .map((pred) => CrowdIndicator(
                                  stationName: pred.stationName,
                                  level: pred.level,
                                  transportType: pred.transportType,
                                  predictedTime: pred.predictedTime,
                                ))
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

            // Jadwal Berangkat
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text('Jadwal Terdekat',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final schedule = homeState.schedules;
                  if (index >= schedule.length) return null;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md, 8, AppSpacing.md, 0),
                    child: ScheduleCard(schedule: schedule[index]),
                  );
                },
                childCount: homeState.schedules.length,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
    );
  }
}
