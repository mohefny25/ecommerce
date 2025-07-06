import 'package:dartz/dartz.dart';

import '../../../features/checkout/data/models/order_model.dart';
import '../../../features/checkout/domain/entites/order_entity.dart';
import '../../errors/failures.dart';
import '../../services/data_service.dart';
import '../../utils/backend_endpoint.dart';
import 'orders_repo.dart';


class OrdersRepoImpl implements OrdersRepo {
  final DatabaseService dataBaseService;

  OrdersRepoImpl(this.dataBaseService);
  @override
  Future<Either<Failure, void>> addOrder(
      {required OrderInputEntity order}) async {
    try {
      var orderModel = OrderModel.fromEntity(order);
      await dataBaseService.addData(
        path: BackendEndpoint.addOrder,
        documentId: orderModel.orderId,
        data: orderModel.toJson(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
