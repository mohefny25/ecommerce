import 'package:dartz/dartz.dart';

import '../../../features/checkout/domain/entites/order_entity.dart';
import '../../errors/failures.dart';


abstract class OrdersRepo {
  Future<Either<Failure, void>> addOrder({required OrderInputEntity order});
}
