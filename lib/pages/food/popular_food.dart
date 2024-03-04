import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../controller/popular_product_controller.dart';
import '../../routes/routes_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimentions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
            left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimentions.popularFoodImageSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                    ),
                  ),
                ),
              ),
          ),
          //icons over BG image
          Positioned(
            top: 45,
            left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      if(page == "cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                      },
                      child: const AppIcon(icon: Icons.arrow_back_ios,)
                  ),
                  GetBuilder<PopularProductController>(builder: (controller){
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap:(){
                            if(controller.totalItems>=1) {
                              Get.toNamed(RouteHelper.getCartPage());
                            }
                          },
                            child: const AppIcon(
                              icon: Icons.shopping_cart_outlined,
                            ),
                        ),
                        controller.totalItems>=1?
                        Positioned(
                          right:0,top:0,
                          child: AppIcon(icon: Icons.circle_sharp,
                            size: 18,
                            iconColor: Colors.transparent,
                            backgroundColor: AppColors.mainColor,),
                        )
                            :Container(),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right:5,top:0,
                          child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                            size: 12,
                            color: Colors.white,
                          )
                        )
                            :Container(),
                      ],
                    );
                  })
                ],
              ),
          ),
          //Name and column area
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimentions.popularFoodImageSize-30,
            child: Container(
              padding: EdgeInsets.only(left: 20,right: 20,top: Dimentions.height10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!),
                  const SizedBox(height: 20,),
                  BigText(text: "Introduce"),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: product.description!,),
                    ),
                  ),
                ],
              ),
          ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15,bottom: 15,left: 15,right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:(){
                        popularProduct.setQuantity(false);
                      },
                      child:
                      Icon(Icons.remove,color: AppColors.signColor,
                      ),
                    ),
                    const SizedBox(width: 5,),
                    BigText(text: popularProduct.inCartItems.toString()),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: (){
                        popularProduct.setQuantity(true);
                      },
                      child:
                      Icon(Icons.add,color: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15,bottom: 15,left: 15,right: 15),
                child: GestureDetector(
                  onTap: (){
                    popularProduct.addItem(product);
                  },
                    child: BigText(text: "₹ ${product.price!} | Add to Cart",color: Colors.white,)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.mainColor,
                ),
              ),
            ],
          ),
        );
      },)
    );
  }
}
