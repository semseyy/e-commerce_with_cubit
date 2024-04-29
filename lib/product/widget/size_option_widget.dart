import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecommerce_with_cubit/feature/home/cubit/home_cubit.dart';
import 'package:ecommerce_with_cubit/feature/home/cubit/home_state.dart';

class SizeOption extends StatelessWidget {
  final String size;

  const SizeOption({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<HomeCubit>().setSize(size);
          },
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: state.selectedSize == size ? Colors.orange : Colors.black,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                size,
                style: TextStyle(
                  color: state.selectedSize == size ? Colors.orange : Colors.black,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
