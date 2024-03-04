import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapidd_btes/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimentions.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText=true;
  double textHeight = Dimentions.screenHeight/5.63;

  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1 , widget.text.length);
    }
    else{
      firstHalf=widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(text: firstHalf):Column(
        children: [
          SmallText(height: 1.3,size:15,color: AppColors.textColor,text: hiddenText?firstHalf+("..."):firstHalf+secondHalf),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
            },
            child: Row(
              children: [
                hiddenText?SmallText(text: "Show more",color: AppColors.mainColor,):SmallText(text: "Show less",color: AppColors.mainColor,),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.mainColor,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
