
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../repos/orders_repo/orders_repo.dart';
import '../repos/orders_repo/orders_repo_impl.dart';
import '../repos/products_repo/products_repo.dart';
import '../repos/products_repo/products_repo_impl.dart';
import 'data_service.dart';
import 'firebase_auth_service.dart';
import 'firestore_service.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FireStoreService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );

  getIt.registerSingleton<ProductsRepo>(
    ProductsRepoImpl(
      getIt<DatabaseService>(),
    ),
  );

  getIt.registerSingleton<OrdersRepo>(
    OrdersRepoImpl(
      getIt<DatabaseService>(),
    ),
  );
}
