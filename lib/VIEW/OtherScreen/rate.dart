import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../components/ratingController.dart';

class rate extends StatefulWidget {
  const rate({Key? key}) : super(key: key);

  @override
  State<rate> createState() => _rateState();
}

class _rateState extends State<rate> {
  static const id = 'rating_page';

  final controller = Get.find<RatingController>();

  Widget _buildBody() {
    final stars = List<Widget>.generate(5, (index) {
      return GetBuilder<RatingController>(
        builder: (controller) => Expanded(
          child: GestureDetector(
            child: controller.buildRatingStar(index),
            onTap: () {
              controller.updateAndStoreRating(index + 1);
            },
          ),
        ),
      );
    });
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: stars,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
