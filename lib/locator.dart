import 'package:get_it/get_it.dart';
import 'package:imospeed_user/service/repository/address_repository.dart';
import 'package:imospeed_user/service/repository/auth_repository.dart';
import 'package:imospeed_user/service/repository/delivery_repository.dart';
import 'package:imospeed_user/service/repository/state_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthRepository());
  locator.registerLazySingleton(() => StateRepository());
  locator.registerLazySingleton(() => AddressRepository());
  locator.registerLazySingleton(() => DeliveryRepository());


}