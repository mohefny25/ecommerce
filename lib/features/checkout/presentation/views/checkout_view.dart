import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

import '../../../../core/helper_functions/get_user.dart';
import '../../../../core/repos/orders_repo/orders_repo.dart';
import '../../../../core/services/get_it_service.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../home/domain/entites/cart_entity.dart';
import '../../domain/entites/order_entity.dart';
import '../../domain/entites/shipping_address_entity.dart';
import '../manger/add_order_cubit/add_order_cubit.dart';
import 'widgets/add_order_cubit_bloc_builder.dart';
import 'widgets/checkout_view_body.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key, required this.cartEntity});

  static const routeName = 'checkout';
  final CartEntity cartEntity;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late OrderInputEntity orderEntity;

  @override
  void initState() {
    super.initState();
    orderEntity = OrderInputEntity(
      uID: getUser().uId,
      widget.cartEntity,
      shippingAddressEntity: ShippingAddressEntity(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddOrderCubit(
        getIt.get<OrdersRepo>(),
      ),
      child: Scaffold(
        appBar: buildAppBar(
          context,
          title: 'الشحن',
          showNotification: false,
        ),
        body: Provider.value(
          value: orderEntity,
          child: const AddOrderCubitBlocBuilder(
            child: CheckoutViewBody(),
          ),
        ),
      ),
    );
  }
}
