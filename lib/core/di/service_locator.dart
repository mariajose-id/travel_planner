import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_planner/features/trips/data/models/trip_model.dart';
import 'package:travel_planner/features/trips/data/repositories/trip_repository_impl.dart';
import 'package:travel_planner/features/trips/domain/repositories/trip_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> setupServiceLocator() async {
  final Box<TripModel> tripsBox = await Hive.openBox<TripModel>('trips');
  final tripRepository = TripRepositoryImpl(tripsBox: tripsBox);
  await tripRepository.initialize();

  serviceLocator.registerSingleton<TripRepository>(tripRepository);
}

TripRepository getTripRepository() {
  return serviceLocator<TripRepository>();
}
