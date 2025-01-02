import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../abstractservices/storage_services.dart';
import '../core/services/api_services/api_service.dart';
import '../core/services/get.dart';
import '../core/services/storageservices/token_manager.dart';
import '../core/services/theme_handler/theme_notifier.dart';
import 'data/datasource/Auth/auth_remote_data_source.dart';
import 'data/datasource/chord_prediction/chord_prediction_remote_data_source.dart';
import 'data/repositories/auth/auth_repo_impl.dart';
import 'data/repositories/chord_prediction/chord_prediction_repo.dart';
import 'domain/repositories/auth/auth_repo.dart';
import 'domain/repositories/chord_prediction/chord_prediction_repo.dart';
import 'presentation/modules/chord_prediction/providers/chord_controller_notifier.dart';
import 'presentation/modules/chord_prediction/providers/music_notifier_provider.dart';

//service dependencies
final storageServiceProvider = Provider<StorageServices>((ref) {
  final box = Get.box;
  ref.onDispose(() => box.close);
  return box;
});

final baseUrlProvider = StateProvider<String>((ref) => dotenv.get('BASEURL'));

final apiServiceProvider = Provider<ApiManager>((ref) {
  ref.watch(baseUrlProvider);
  return ApiManager(ref);
});

// final predictedDataProvider = StateProvider<List<ChordPrediction>>((ref) => []);

final tokenManagerProvider = Provider<TokenManager>(
    (ref) => TokenManager(ref.read(storageServiceProvider)));

final themeNotifierProvider = ChangeNotifierProvider<ThemeNotifier>(
    (ref) => ThemeNotifier(ref.read(storageServiceProvider)));
//Auth Dependencies

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
    (ref) => AuthRemoteDataSourceImpl(ref.read(apiServiceProvider)));

final authRepoProvider = Provider<AuthRepo>((ref) => AuthRepoImpl(
    ref.read(authRemoteDataSourceProvider), ref.read(tokenManagerProvider)));

// chord Prediction

final chordPredictionRemoteDataSourceProvider =
    Provider<ChordPredictionRemoteDataSource>((ref) =>
        ChordPredictionRemoteDataSourceImpl(ref.read(apiServiceProvider)));

final chordPredictionRepoProvider = Provider<ChordPredictionRepo>((ref) =>
    ChordPredictionRepoImpl(ref.read(chordPredictionRemoteDataSourceProvider)));

final chordPredictionNotifier = ChangeNotifierProvider<ChordControllerNotifier>(
    (ref) => ChordControllerNotifier(ref.watch(musicFileProvider)!));
