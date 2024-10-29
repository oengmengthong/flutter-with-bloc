import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
}