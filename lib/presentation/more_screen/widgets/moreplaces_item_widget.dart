import 'package:flutter/material.dart';
import 'package:tarini/core/utils/image_constant.dart';
import '../../../core/app_expsrt.dart';

class MoreplacesItemWidget extends StatelessWidget {
  const MoreplacesItemWidget({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: CustomImageView(
        imagePath: ImageConstant.beach1_img,
        height: 184,
        width: 180,
      ),
    );
  }
}
