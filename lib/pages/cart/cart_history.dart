import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/no_data_page.dart';
import '../../controller/cart_controller.dart';
import '../../models/cart_models.dart';
import '../../routes/routes_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, int> cartItemsPerOrder = {};
    var getCartHistoryList =
    Get.find<CartController>().getCartHistoryList().reversed.toList();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(
            getCartHistoryList[i].time.toString(), () => 1);
      }
    }

    List<int> cartItemsPerOrderList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderList();
    var listCounter = 0;

    Widget timeWidget(int index){
      var op = DateTime.now().toString();
      var optime = DateTime.now().toString();
      if(index< getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var date = DateFormat("dd/MM/yyyy");
        var time = DateFormat("hh:mm a");
        op = date.format(inputDate);
        optime = time.format(inputDate);
      }
      return SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigText(text: "Order Date: "+op),
            SmallText(text: "Time: "+optime,color: AppColors.titleColor,),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.only(top: 45,left: 20,right: 20,bottom: 10),
            color: AppColors.mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(text: "Your Cart History",color: Colors.white,),
                AppIcon(icon: Icons.home_outlined,iconColor: AppColors.mainColor,iconSize: 22,),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            if (_cartController.getCartHistoryList().isNotEmpty) {
              return Expanded(
              child: Container(
                  margin: const EdgeInsets.only(top: 15 , left:  10 , right:  10),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for(int i = 0 ; i < itemsPerOrder.length ; i++)
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[100],
                                border: Border.all(width: 0.1,color: Colors.grey)
                            ),
                            padding: EdgeInsets.all(5),
                            height: 120,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                timeWidget(listCounter),
                                const SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(itemsPerOrder[i], (index) {
                                        if(listCounter<getCartHistoryList.length){
                                          listCounter++;
                                        }
                                        return index<=2?Container(
                                          height: 70,
                                          width: 70,
                                          margin: EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!
                                                  )
                                              )
                                          ),
                                        ):Container();
                                      }),
                                    ),
                                    Container(
                                      height: 70,
                                      child:Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SmallText(text: "Total: ",color: AppColors.titleColor,),
                                          BigText(text: itemsPerOrder[i].toString()+" items",color: AppColors.mainBlackColor,),
                                          GestureDetector(
                                            onTap: (){
                                              var orderTime = cartOrderTimeToList();
                                              Map<int,CartModel>  moreOrder = {};
                                              for(int j = 0 ; j < getCartHistoryList.length; j++){
                                                if(getCartHistoryList[j].time == orderTime[i]){
                                                  moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                      CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                  );
                                                }
                                              }
                                              Get.find<CartController>().setItems = moreOrder;
                                              Get.find<CartController>().addToCartList();
                                              Get.toNamed(RouteHelper.getCartPage());
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(width: 1,color: AppColors.mainColor),
                                                color: Colors.white,
                                              ),
                                              child: SmallText(text: "Order again",color: AppColors.mainColor,),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                      ],
                    ),)

              ),
            );
            } else {
              return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height/1.5,
                  child: const NoDataPage(
                    text: "Your Order History is Empty 😒",imgPath: "assets/image/empty_box.png",)),
            );
            }
          })
        ],
      ),
    );
  }
}
