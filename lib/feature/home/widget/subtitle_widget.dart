import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class subtitle extends StatelessWidget {
  const subtitle({
    super.key,
    required List<String> subtitles,
    required int currentSubtitleIndex,
  })  : _subtitles = subtitles,
        _currentSubtitleIndex = currentSubtitleIndex;

  final List<String> _subtitles;
  final int _currentSubtitleIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.shade600,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        _subtitles[_currentSubtitleIndex],
        style: TextStyle(fontSize: 18.sp, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
