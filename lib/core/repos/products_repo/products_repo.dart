import 'package:dartz/dartz.dart';

import '../../entities/product_entity.dart';
import '../../errors/failures.dart';


abstract class ProductsRepo {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, List<ProductEntity>>> getBestSellingProducts();
}
