import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../abstractservices/api_manager.dart';
import '../abstractservices/response_cache_service.dart';
import '../abstractservices/storage_services.dart';
import '../abstractservices/theme_notifier.dart';
import '../abstractservices/token_manager.dart';
import '../core/services/api_services/api_service.dart';
import '../core/services/get.dart';
import '../core/services/storageservices/response_cache.dart';
import '../core/services/storageservices/token_service.dart';
import '../core/services/theme_handler/theme_notifier_impl.dart';
import 'data/datasource/Auth/auth_remote_data_source.dart';
import 'data/datasource/chord_prediction/chord_prediction_remote_data_source.dart';
import 'data/datasource/saved_prediction/saved_prediction_local_data_source.dart';
import 'data/repositories/auth/auth_repo_impl.dart';
import 'data/repositories/chord_prediction/chord_prediction_repo.dart';
import 'data/repositories/saved_prediction/saved_prediction_impl.dart';
import 'domain/repositories/auth/auth_repo.dart';
import 'domain/repositories/chord_prediction/chord_prediction_repo.dart';
import 'domain/repositories/saved_prediction/saved_prediction_repo.dart';
import 'presentation/modules/chord_prediction/providers/chord_controller_notifier.dart';
import 'presentation/modules/saved_prediction/providers/saved_classification_providers.dart';

//service dependencies
final storageServiceProvider = Provider<StorageServices>((ref) {
  final box = Get.box;
  ref.onDispose(() => box.close);
  return box;
});

final baseUrlProvider = StateProvider<String>((ref) => dotenv.get('BASEURL'));

final apiServiceProvider = Provider<ApiManager>((ref) {
  ref.watch(baseUrlProvider);
  return ApiManagerImpl(ref);
});

final responseCacheProvider = Provider<ResponseCache>(
    (ref) => ResponseCacheImpl(ref.read(storageServiceProvider)));

final tokenManagerProvider = Provider<TokenManager>((ref) => TokenServices());

final themeNotifierProvider =
    ChangeNotifierProvider<ThemeNotifier>((ref) => ThemeNotifierImpl());

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

final chordPredictionNotifier = ChangeNotifierProviderFamily((ref, File file) =>
    ChordControllerNotifier(file, ref.read(savedClassificationProvider)));

//SavedLocalValues
final savedLocalDataSrc = Provider<SavedPredictionLocalDataSrc>(
    (ref) => SavedPredictionLocalDataSrcImpl(ref.read(storageServiceProvider)));

final savedLocalDataRepo = Provider<SavedPredictionRepo>(
    (ref) => SavedPredictionImpl(ref.read(savedLocalDataSrc)));

final savedClassificationProvider = ChangeNotifierProvider(
    (ref) => SavedClassification(ref.read(storageServiceProvider)));

final fetchSavedDataProvider = FutureProvider((ref) async {
  final savedChords = await ref.read(savedLocalDataRepo).fetchChords();
  ref.read(savedClassificationProvider).initRef(ref, savedChords);
});
