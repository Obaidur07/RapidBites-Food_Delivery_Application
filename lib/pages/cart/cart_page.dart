import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/no_data_page.dart';
import '../../controller/cart_controller.dart';
import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';
import '../../routes/routes_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 60,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                  BigText(text: "Your Cart",),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: 22,
                    ),
                  ),
                ],
              ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            if (_cartController.getItems.isNotEmpty) {
              return Positioned(
                top: 110,
                left: 15,
                right: 15,
                bottom: 0,
                child: Container(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartController){
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_,index){
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[100],
                                  border: Border.all(width: 0.1,color: Colors.grey)
                              ),
                              margin: const EdgeInsets.only(bottom: 5,top: 5),
                              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 10),
                              height: 120,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      var popularIndex = Get.find<PopularProductController>().popularProductList.indexOf(_cartList[index].product!);
                                      if (popularIndex >= 0){
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                      }else{
                                        var recommendedIndex = Get.find<RecommendedProductController>().recommendedProductList.indexOf(_cartList[index].product!);
                                        if(recommendedIndex<0){
                                          Get.snackbar('Warning!',  "You can't go back from this Page !!");
                                        }else{
                                          Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      margin: const EdgeInsets.only(bottom: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:  Colors.white,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                            text: cartController.getItems[index].name!,
                                            color: AppColors.mainBlackColor,
                                          ),
                                          SmallText(
                                            text: "Extra spicy",
                                            color: AppColors.textColor,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text: "₹${cartController.getItems[index].price.toString()}",
                                                color: Colors.redAccent,
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap:(){
                                                        cartController.addItem(_cartList[index].product!, -1);
                                                      },
                                                      child:
                                                      Icon(Icons.remove,color: AppColors.signColor,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5,),
                                                    BigText(text: _cartList[index].quantity.toString()),
                                                    const SizedBox(width: 5,),
                                                    GestureDetector(
                                                      onTap: (){
                                                        cartController.addItem(_cartList[index].product!, 1);
                                                      },
                                                      child:
                                                      Icon(Icons.add,color: AppColors.signColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },),
                  ),
                )
            );
            } else {
              return const NoDataPage(text: "Your Cart is Empty "+"😒");
            }
          })
        ],
      ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
          return Container(
            height: 120,
            padding: const EdgeInsets.only(top: 30,bottom: 30,left: 20,right: 20),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
            child: cartController.getItems.isNotEmpty ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.only(left: 12,right: 12,top: 10,bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.mainColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallText(text: "total amount: ",
                          color: Colors.white,
                        ),
                        BigText(text:"₹"+cartController.totalAmount.toString(),
                          color: Colors.white,
                        )
                      ],
                    )
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15,bottom: 15,left: 15,right: 15),
                  child: GestureDetector(
                      onTap: (){
                        //popularProduct.addItem(product);
                        cartController.addToHistory();
                      },
                      child: BigText(text: "Confirm Payment",color: Colors.white,)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.mainColor,
                  ),
                ),
              ],
            ):Container(),
          );
        },)
    );
  }
}
//_cartList.length