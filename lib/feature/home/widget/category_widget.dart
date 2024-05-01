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
      children: List.generate(
        categories.length,
        (index) => GestureDetector(
          onTap: () {
            if (onCategorySelected != null) {
              if (selectedIndex == index) {
                // If the tapped category is already selected, deselect it
                onCategorySelected!(-1); // Deselect the category
              } else {
                onCategorySelected!(index); // Select the tapped category
              }
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: selectedIndex == index ? Colors.orange : Colors.grey[200],
              borderRadius: BorderRadius.circular(20.0.r),
            ),
            child: Text(
              categories[index],
              style: TextStyle(
                color: selectedIndex == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
