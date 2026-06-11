import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../features/auth/providers/auth_provider.dart';
import '../../../main.dart';
import '../../../data/database/app_database.dart';
import 'package:drift/drift.dart' show Value;

// ============================================================
// GAME MODEL
// ============================================================

class RouteNode {
  final String id;
  final String name;
  final String type; // KRL, MRT, Busway, Jalan
  final int cost; // "waktu" dalam menit
  final int crowdLevel;

  const RouteNode({
    required this.id,
    required this.name,
    required this.type,
    required this.cost,
    required this.crowdLevel,
  });

  Color get color {
    switch (type) {
      case 'MRT': return AppTheme.accentTeal;
      case 'LRT': return AppTheme.safeGreen;
      case 'Busway': return AppTheme.warningAmber;
      case 'Jalan': return Colors.grey;
      default: return AppTheme.primaryBlue;
    }
  }

  IconData get icon {
    switch (type) {
      case 'Busway': return Icons.directions_bus_rounded;
      case 'Jalan': return Icons.directions_walk_rounded;
      default: return Icons.train_rounded;
    }
  }
}

class GameLevel {
  final int level;
  final String origin;
  final String destination;
  final List<RouteNode> availableNodes;
  final int targetMinutes; // waktu terbaik yang harus dicapai
  final int timeLimit;     // batas waktu bermain (detik)

  const GameLevel({
    required this.level,
    required this.origin,
    required this.destination,
    required this.availableNodes,
    required this.targetMinutes,
    required this.timeLimit,
  });
}

// ============================================================
// GAME SCREEN
// ============================================================

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  int _currentLevel = 1;
  List<RouteNode> _selectedRoute = [];
  Timer? _timer;
  int _timeLeft = 60;
  bool _gameOver = false;
  bool _levelComplete = false;
  int _score = 0;
  int _totalScore = 0;

  final _levels = _buildLevels();

  static List<GameLevel> _buildLevels() {
    return [
      GameLevel(
        level: 1,
        origin: 'Bogor',
        destination: 'Sudirman',
        availableNodes: [
          const RouteNode(id: 'n1', name: 'KRL Bogor-Kota', type: 'KRL', cost: 45, crowdLevel: 4),
          const RouteNode(id: 'n2', name: 'Busway Bogor', type: 'Busway', cost: 90, crowdLevel: 2),
          const RouteNode(id: 'n3', name: 'KRL + Jalan', type: 'KRL', cost: 50, crowdLevel: 3),
          const RouteNode(id: 'n4', name: 'MRT Lebak Bulus', type: 'MRT', cost: 35, crowdLevel: 5),
          const RouteNode(id: 'n5', name: 'KRL via Manggarai', type: 'KRL', cost: 40, crowdLevel: 3),
        ],
        targetMinutes: 40,
        timeLimit: 60,
      ),
      GameLevel(
        level: 2,
        origin: 'Bekasi',
        destination: 'Harmoni',
        availableNodes: [
          const RouteNode(id: 'n6', name: 'KRL Bekasi-Kota', type: 'KRL', cost: 55, crowdLevel: 5),
          const RouteNode(id: 'n7', name: 'Busway + MRT', type: 'Busway', cost: 70, crowdLevel: 2),
          const RouteNode(id: 'n8', name: 'KRL + Busway', type: 'KRL', cost: 60, crowdLevel: 3),
          const RouteNode(id: 'n9', name: 'LRT Jabodebek', type: 'LRT', cost: 50, crowdLevel: 2),
          const RouteNode(id: 'n10', name: 'MRT Bundaran HI', type: 'MRT', cost: 45, crowdLevel: 4),
        ],
        targetMinutes: 50,
        timeLimit: 50,
      ),
      GameLevel(
        level: 3,
        origin: 'Tangerang',
        destination: 'Blok M',
        availableNodes: [
          const RouteNode(id: 'n11', name: 'KRL Tangerang-Kota', type: 'KRL', cost: 40, crowdLevel: 3),
          const RouteNode(id: 'n12', name: 'Busway Tangerang', type: 'Busway', cost: 80, crowdLevel: 1),
          const RouteNode(id: 'n13', name: 'KRL + MRT', type: 'KRL', cost: 45, crowdLevel: 2),
          const RouteNode(id: 'n14', name: 'MRT Lebak Bulus', type: 'MRT', cost: 35, crowdLevel: 4),
          const RouteNode(id: 'n15', name: 'Jalan + KRL + MRT', type: 'Jalan', cost: 50, crowdLevel: 2),
        ],
        targetMinutes: 38,
        timeLimit: 45,
      ),
    ];
  }

  GameLevel get _level => _levels[(_currentLevel - 1).clamp(0, _levels.length - 1)];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timeLeft = _level.timeLimit;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _gameOver = true;
          t.cancel();
        }
      });
    });
  }

  void _selectNode(RouteNode node) {
    if (_gameOver || _levelComplete) return;
    setState(() {
      if (_selectedRoute.contains(node)) {
        _selectedRoute.remove(node);
      } else {
        _selectedRoute.add(node);
      }
    });
  }

  void _submitRoute() {
    if (_selectedRoute.isEmpty) return;
    _timer?.cancel();

    final totalCost = _selectedRoute.fold(0, (sum, n) => sum + n.cost);
    final avgCrowd = _selectedRoute.fold(0.0, (sum, n) => sum + n.crowdLevel) / _selectedRoute.length;

    // Skor berdasarkan: waktu tersisa + seberapa dekat ke target
    final timeDiff = (totalCost - _level.targetMinutes).abs();
    final crowdBonus = (5 - avgCrowd).clamp(0, 5) * 10;
    final timeBonus = _timeLeft * 2;
    final accuracyBonus = max(0, 50 - timeDiff * 2);
    final levelScore = (timeBonus + crowdBonus + accuracyBonus).round();

    setState(() {
      _score = levelScore;
      _totalScore += levelScore;
      _levelComplete = true;
    });

    _saveScore(levelScore);
  }

  Future<void> _saveScore(int score) async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;
    final db = ref.read(appDatabaseProvider);
    await db.insertGameScore(GameScoresCompanion.insert(
      userId: user.id,
      level: _currentLevel,
      score: score,
      timeUsed: _level.timeLimit - _timeLeft,
      completed: const Value(true),
    ));
  }

  void _nextLevel() {
    if (_currentLevel >= _levels.length) {
      _showFinalScore();
      return;
    }
    setState(() {
      _currentLevel++;
      _selectedRoute = [];
      _levelComplete = false;
      _gameOver = false;
    });
    _startTimer();
  }

  void _restart() {
    setState(() {
      _currentLevel = 1;
      _selectedRoute = [];
      _levelComplete = false;
      _gameOver = false;
      _score = 0;
      _totalScore = 0;
    });
    _startTimer();
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('🏆 Game Selesai!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total Skor: $_totalScore',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: 8),
            Text('Kamu telah menyelesaikan ${_levels.length} level!'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Keluar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _restart();
            },
            child: const Text('Main Lagi'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Planner Puzzle'),
        actions: [
          IconButton(
            onPressed: _restart,
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Mulai Ulang',
          ),
        ],
      ),
      body: Column(
        children: [
          // Game Header
          _GameHeader(
            level: _currentLevel,
            totalLevels: _levels.length,
            timeLeft: _timeLeft,
            totalScore: _totalScore,
            timeLimit: _level.timeLimit,
          ),

          // Puzzle Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mission
                  _MissionCard(level: _level),
                  const SizedBox(height: 16),

                  // Route Options
                  Text('Pilih Moda Transportasi:',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    'Pilih kombinasi terbaik untuk mencapai target ${_level.targetMinutes} menit atau lebih cepat',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),

                  if (_gameOver)
                    _GameOverBanner(onRestart: _restart)
                  else if (_levelComplete)
                    _LevelCompleteBanner(
                      score: _score,
                      selectedRoute: _selectedRoute,
                      targetMinutes: _level.targetMinutes,
                      onNext: _nextLevel,
                      isLastLevel: _currentLevel >= _levels.length,
                    )
                  else ...[
                    // Node cards
                    ...(_level.availableNodes.map((node) => _NodeCard(
                          node: node,
                          isSelected: _selectedRoute.contains(node),
                          onTap: () => _selectNode(node),
                        ))),

                    const SizedBox(height: 16),

                    // Selected summary
                    if (_selectedRoute.isNotEmpty) _RouteSummary(route: _selectedRoute),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed:
                            _selectedRoute.isNotEmpty ? _submitRoute : null,
                        icon: const Icon(Icons.check_circle_rounded),
                        label: const Text('Konfirmasi Rute'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GameHeader extends StatelessWidget {
  final int level, totalLevels, timeLeft, totalScore, timeLimit;
  const _GameHeader({
    required this.level,
    required this.totalLevels,
    required this.timeLeft,
    required this.totalScore,
    required this.timeLimit,
  });

  @override
  Widget build(BuildContext context) {
    final pct = timeLeft / timeLimit;
    final timerColor =
        pct > 0.5 ? AppTheme.safeGreen : pct > 0.25 ? AppTheme.warningAmber : AppTheme.dangerCoral;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Row(
            children: [
              Text('Level $level/$totalLevels',
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              const Spacer(),
              Icon(Icons.timer_rounded, size: 16, color: timerColor),
              const SizedBox(width: 4),
              Text(
                '$timeLeft detik',
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: timerColor),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.stars_rounded, size: 16, color: AppTheme.warningAmber),
              const SizedBox(width: 4),
              Text('$totalScore',
                  style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: pct,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(timerColor),
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}

class _MissionCard extends StatelessWidget {
  final GameLevel level;
  const _MissionCard({required this.level});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryBlue.withOpacity(0.8),
            AppTheme.accentTeal.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🎯 Misi', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(level.origin,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded,
                  color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(level.destination,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Target: ≤ ${level.targetMinutes} menit  |  Skor bonus untuk kepadatan rendah!',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _NodeCard extends StatelessWidget {
  final RouteNode node;
  final bool isSelected;
  final VoidCallback onTap;

  const _NodeCard({
    required this.node,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? node.color.withOpacity(0.15)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? node.color : Theme.of(context).dividerColor.withOpacity(0.2),
            width: isSelected ? 1.5 : 0.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: node.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(node.icon, color: node.color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(node.name,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      _InfoChip(
                          '${node.cost} menit', Icons.timer_outlined,
                          AppTheme.primaryBlue),
                      const SizedBox(width: 6),
                      _InfoChip(
                          'Kepadatan ${node.crowdLevel}/5',
                          Icons.people_outline_rounded,
                          node.crowdLevel <= 2
                              ? AppTheme.safeGreen
                              : node.crowdLevel <= 3
                                  ? AppTheme.warningAmber
                                  : AppTheme.dangerCoral),
                    ],
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded,
                  color: node.color, size: 22),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _InfoChip(this.label, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: color),
        const SizedBox(width: 2),
        Text(label,
            style: TextStyle(fontSize: 11, color: color)),
      ],
    );
  }
}

class _RouteSummary extends StatelessWidget {
  final List<RouteNode> route;
  const _RouteSummary({required this.route});

  @override
  Widget build(BuildContext context) {
    final total = route.fold(0, (sum, n) => sum + n.cost);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: AppTheme.primaryBlue.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.route_rounded,
              color: AppTheme.primaryBlue, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              route.map((n) => n.name).join(' → '),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Text(
            '$total menit',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}

class _GameOverBanner extends StatelessWidget {
  final VoidCallback onRestart;
  const _GameOverBanner({required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.dangerCoral.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.dangerCoral.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Icon(Icons.timer_off_rounded,
              color: AppTheme.dangerCoral, size: 36),
          const SizedBox(height: 8),
          const Text('Waktu Habis!',
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 18)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onRestart,
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }
}

class _LevelCompleteBanner extends StatelessWidget {
  final int score;
  final List<RouteNode> selectedRoute;
  final int targetMinutes;
  final VoidCallback onNext;
  final bool isLastLevel;

  const _LevelCompleteBanner({
    required this.score,
    required this.selectedRoute,
    required this.targetMinutes,
    required this.onNext,
    required this.isLastLevel,
  });

  @override
  Widget build(BuildContext context) {
    final total = selectedRoute.fold(0, (s, n) => s + n.cost);
    final achieved = total <= targetMinutes;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            achieved ? AppTheme.safeGreen.withOpacity(0.1) : AppTheme.warningAmber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: achieved
                ? AppTheme.safeGreen.withOpacity(0.3)
                : AppTheme.warningAmber.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            achieved ? '🎉 Target Tercapai!' : '✅ Level Selesai',
            style: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'Waktu rute: $total menit  |  Target: $targetMinutes menit',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Skor: +$score poin',
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryBlue),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onNext,
            child: Text(isLastLevel ? 'Lihat Skor Akhir' : 'Level Berikutnya →'),
          ),
        ],
      ),
    );
  }
}
