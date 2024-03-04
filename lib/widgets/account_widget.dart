import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_icon.dart';
import 'big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key,required this.bigText,required this.appIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10,left: 10,right: 10),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(2,2),
            color: Colors.grey.withOpacity(0.3),
          )
        ]
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
            BoxShadow(
              blurRadius: 1,
              offset: const Offset(0,2),
              color: Colors.grey.withOpacity(0.2),
              ),
            ],),
            child: appIcon,
          ),
          SizedBox(width: 20,),
          bigText,
        ],
      ),
    );
  }
}
