import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageCarouselSlider extends StatefulWidget {
  final List<String> images;
  final Function(int)? onPageChanged;

  const ImageCarouselSlider({
    Key? key,
    required this.images,
    this.onPageChanged,
  }) : super(key: key);

  @override
  _ImageCarouselSliderState createState() => _ImageCarouselSliderState();
}

class _ImageCarouselSliderState extends State<ImageCarouselSlider> {
  int _activeIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: widget.images.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage = widget.images[index];
            return _buildImage(urlImage);
          },
          options: CarouselOptions(
            height: 200.h,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() {
                _activeIndex = index;
              });
              if (widget.onPageChanged != null) {
                widget.onPageChanged!(index);
              }
            },
            enlargeCenterPage: true,
            viewportFraction: 0.8,
            pageSnapping: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(height: 12.h),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: _activeIndex,
        count: widget.images.length,
        effect: ExpandingDotsEffect(
          dotHeight: 10.h,
          dotWidth: 10.w,
          activeDotColor: Colors.teal,
        ),
      );

  Widget _buildImage(String urlImage) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Image.network(
            urlImage,
            width: double.infinity,
            height: 200.h,
            fit: BoxFit.cover,
          ),
        ),
      );
}
