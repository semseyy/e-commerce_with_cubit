import 'package:ecommerce_with_cubit/product/consdant/color_consdant.dart';
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: widget.images.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage = widget.images[index];
              return _buildImage(urlImage);
            },
            options: CarouselOptions(
              height: 300.h, // Yüksekliği artırıldı
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
              viewportFraction: 0.7,
              pageSnapping: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        SizedBox(height: 10.h),
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
          activeDotColor: tealColor,
        ),
      );

  Widget _buildImage(String urlImage) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.network(
            urlImage,
            width: double.infinity, // Fotoğrafın genişliği tüm alanı kaplayacak şekilde ayarlandı
            height: 300.h, // Yükseklik belirlendi
            fit: BoxFit.fill, // Fotoğrafın tamamının görünmesi sağlandı
          ),
        ),
      );
}
