import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapidd_btes/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimentions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        BigText(text: text, size: 20,),
        SizedBox(height: Dimentions.height10,),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) => Icon(Icons.star
                ,color: AppColors.mainColor,
                size: 15,),
              ),
            ),
            SizedBox(width: 2,),
            SmallText(text: "4.5"),
            SizedBox(width: 10,),
            Icon(Icons.comment_rounded,size: 15,color: AppColors.textColor,),
            SizedBox(width: 5,),
            SmallText(text: "1087"),
          ],
        ),
        SizedBox(height: Dimentions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(icon: Icons.location_on,
                text: "1.7 Km",
                iconColor: AppColors.mainColor),
            IconAndTextWidget(icon: Icons.access_time,
                text: "39 min",
                iconColor: AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}
