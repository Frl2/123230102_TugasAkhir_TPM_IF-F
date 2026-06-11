import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// ============================================================
// TABLES
// ============================================================

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 3, max: 50)();
  TextColumn get email => text().withLength(min: 5, max: 100)();
  TextColumn get passwordHash => text()();
  TextColumn get salt => text()();
  TextColumn get fullName => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  BoolColumn get biometricEnabled => boolean().withDefault(const Constant(false))();
  TextColumn get sessionToken => text().nullable()();
  DateTimeColumn get sessionExpiry => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class Trips extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get origin => text()();
  TextColumn get destination => text()();
  TextColumn get routeJson => text()(); // JSON encoded route
  TextColumn get transportModes => text()(); // JSON list
  RealColumn get crowdScore => real().nullable()();
  RealColumn get estimatedMinutes => real().nullable()();
  RealColumn get fareIdr => real().nullable()();
  DateTimeColumn get tripDate => dateTime().withDefault(currentDateAndTime)();
}

class CrowdReports extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get stationId => text()();
  TextColumn get stationName => text()();
  IntColumn get level => integer()(); // 1-5
  IntColumn get reporterId => integer().references(Users, #id)();
  TextColumn get transportType => text()();
  TextColumn get direction => text().nullable()();
  DateTimeColumn get reportedAt => dateTime().withDefault(currentDateAndTime)();
}

class Incidents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get type => text()(); // 'crash', 'fall', 'hard_brake'
  RealColumn get accelX => real()();
  RealColumn get accelY => real()();
  RealColumn get accelZ => real()();
  RealColumn get magnitude => real()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get locationDesc => text().nullable()();
  BoolColumn get notificationSent => boolean().withDefault(const Constant(false))();
  DateTimeColumn get detectedAt => dateTime().withDefault(currentDateAndTime)();
}

class GameScores extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get level => integer()();
  IntColumn get score => integer()();
  IntColumn get timeUsed => integer()(); // dalam detik
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get playedAt => dateTime().withDefault(currentDateAndTime)();
}

class FeedbackEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get subject => text()();
  TextColumn get saran => text()();
  TextColumn get kesan => text()();
  IntColumn get rating => integer()(); // 1-5
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class FavoriteRoutes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get name => text()();
  TextColumn get origin => text()();
  TextColumn get destination => text()();
  TextColumn get transportModes => text()();
  DateTimeColumn get savedAt => dateTime().withDefault(currentDateAndTime)();
}

// ============================================================
// DATABASE CLASS
// ============================================================

@DriftDatabase(tables: [
  Users,
  Trips,
  CrowdReports,
  Incidents,
  GameScores,
  FeedbackEntries,
  FavoriteRoutes,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      // Handle future migrations here
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'urbansafe_db',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
      ),
    );
  }

  // =====================
  // USER OPERATIONS
  // =====================
  Future<User?> getUserByUsername(String username) =>
      (select(users)..where((u) => u.username.equals(username)))
          .getSingleOrNull();

  Future<User?> getUserById(int id) =>
      (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();

  Future<int> insertUser(UsersCompanion user) => into(users).insert(user);

  Future<bool> updateUser(UsersCompanion user) => update(users).replace(user);

  Future updateSession(int userId, String? token, DateTime? expiry) =>
      (update(users)..where((u) => u.id.equals(userId))).write(
        UsersCompanion(
          sessionToken: Value(token),
          sessionExpiry: Value(expiry),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updateProfilePhoto(int userId, String photoPath) =>
      (update(users)..where((u) => u.id.equals(userId))).write(
        UsersCompanion(
          photoPath: Value(photoPath),
          updatedAt: Value(DateTime.now()),
        ),
      );

  Future updateUserAvatar(int userId, String path) =>
      updateProfilePhoto(userId, path);

  Future updateUserProfile({required int id, required String name, required String email, String? phone}) =>
      (update(users)..where((u) => u.id.equals(id))).write(
        UsersCompanion(
          fullName: Value(name),
          email: Value(email),
          phone: Value(phone),
          updatedAt: Value(DateTime.now()),
        ),
      );

  // =====================
  // TRIP OPERATIONS
  // =====================
  Future<List<Trip>> getTripsByUser(int userId, {int limit = 20}) =>
      (select(trips)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.tripDate)])
            ..limit(limit))
          .get();

  Future<int> insertTrip(TripsCompanion trip) => into(trips).insert(trip);

  // =====================
  // CROWD REPORTS
  // =====================
  Future<List<CrowdReport>> getCrowdReportsByStation(String stationId) =>
      (select(crowdReports)
            ..where((c) => c.stationId.equals(stationId))
            ..orderBy([(c) => OrderingTerm.desc(c.reportedAt)])
            ..limit(10))
          .get();

  Future<int> insertCrowdReport(CrowdReportsCompanion report) =>
      into(crowdReports).insert(report);

  Future<double?> getAverageCrowdLevel(String stationId) async {
    final reports = await getCrowdReportsByStation(stationId);
    if (reports.isEmpty) return null;
    final avg = reports.map((r) => r.level).reduce((a, b) => a + b) /
        reports.length;
    return avg;
  }

  // =====================
  // INCIDENTS
  // =====================
  Future<List<Incident>> getIncidentsByUser(int userId) =>
      (select(incidents)
            ..where((i) => i.userId.equals(userId))
            ..orderBy([(i) => OrderingTerm.desc(i.detectedAt)])
            ..limit(50))
          .get();

  Future<int> insertIncident(IncidentsCompanion incident) =>
      into(incidents).insert(incident);

  // =====================
  // GAME SCORES
  // =====================
  Future<List<GameScore>> getTopScores({int limit = 10}) =>
      (select(gameScores)
            ..orderBy([(g) => OrderingTerm.desc(g.score)])
            ..limit(limit))
          .get();

  Future<GameScore?> getHighScore(int userId, int level) =>
      (select(gameScores)
            ..where((g) => g.userId.equals(userId) & g.level.equals(level))
            ..orderBy([(g) => OrderingTerm.desc(g.score)])
            ..limit(1))
          .getSingleOrNull();

  Future<int> insertGameScore(GameScoresCompanion score) =>
      into(gameScores).insert(score);

  // =====================
  // FEEDBACK
  // =====================
  Future<List<FeedbackEntry>> getFeedbackByUser(int userId) =>
      (select(feedbackEntries)
            ..where((f) => f.userId.equals(userId))
            ..orderBy([(f) => OrderingTerm.desc(f.createdAt)]))
          .get();

  Future<int> insertFeedback(FeedbackEntriesCompanion feedback) =>
      into(feedbackEntries).insert(feedback);

  Future<int> insertFeedbackNamed({
    required int userId,
    required String category,
    required String message,
    required int rating,
  }) =>
      into(feedbackEntries).insert(FeedbackEntriesCompanion.insert(
        userId: userId,
        subject: category,
        saran: message,
        kesan: '',
        rating: rating,
      ));

  // =====================
  // FAVORITE ROUTES
  // =====================
  Future<List<FavoriteRoute>> getFavoriteRoutes(int userId) =>
      (select(favoriteRoutes)
            ..where((f) => f.userId.equals(userId))
            ..orderBy([(f) => OrderingTerm.desc(f.savedAt)]))
          .get();

  Future<int> insertFavoriteRoute(FavoriteRoutesCompanion route) =>
      into(favoriteRoutes).insert(route);

  Future deleteFavoriteRoute(int id) =>
      (delete(favoriteRoutes)..where((f) => f.id.equals(id))).go();
}
