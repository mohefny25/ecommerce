import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helper_functions/build_error_bar.dart';
import '../../../../../core/widgets/custom_progress_hud.dart';
import '../../manger/add_order_cubit/add_order_cubit.dart';

class AddOrderCubitBlocBuilder extends StatelessWidget {
  const AddOrderCubitBlocBuilder({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOrderCubit, AddOrderState>(
      listener: (context, state) {
        if (state is AddOrderSuccess) {
          showBar(context, 'تمت العملية بنجاح');
        }

        if (state is AddOrderFailure) {
          showBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
            isLoading: state is AddOrderLoading, child: child);
      },
    );
  }
}
