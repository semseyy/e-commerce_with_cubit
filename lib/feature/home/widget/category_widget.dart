import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryWidget extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int>? onCategorySelected;

  const CategoryWidget({
    Key? key,
    required this.categories,
    required this.selectedIndex,
    this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w, // Horizontal spacing between categories
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(
        categories.length,
        (index) => GestureDetector(
          onTap: () {
            print('Category $index selected');
            if (onCategorySelected != null) {
              onCategorySelected!(index);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: selectedIndex == index ? Colors.teal : Colors.grey[200],
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              categories[index],
              style: TextStyle(
                color: selectedIndex == index ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
