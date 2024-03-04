import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widgets/account_widget.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: BigText(
            text: "Profile",
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            AppIcon(
                icon: Icons.person,
                iconColor: Colors.white,
                backgroundColor: AppColors.mainColor,
                size: 150,
                iconSize: 75,
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AccountWidget(
                      bigText: BigText(text: "Obaid",),
                      appIcon: AppIcon(
                        icon: Icons.person,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        size: 40,
                        iconSize: 20,
                      ),
                    ),
                    AccountWidget(
                      bigText: BigText(text: "9569831384",),
                      appIcon: AppIcon(
                        icon: Icons.call,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.yellowColor,
                        size: 40,
                        iconSize: 20,
                      ),
                    ),
                    AccountWidget(
                      bigText: BigText(text: "rahmanobaid571@gmail..",),
                      appIcon: AppIcon(
                        icon: Icons.email_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.yellowColor,
                        size: 40,
                        iconSize: 20,
                      ),
                    ),
                    AccountWidget(
                      bigText: BigText(text: "P/O Shiv Puri New...",),
                      appIcon: AppIcon(
                        icon: Icons.location_on,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.yellowColor,
                        size: 40,
                        iconSize: 20,
                      ),
                    ),
                    AccountWidget(
                      bigText: BigText(text: "Comments",),
                      appIcon: AppIcon(
                        icon: Icons.message_rounded,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.signColor,
                        size: 40,
                        iconSize: 20,
                      ),
                    ),
                    AccountWidget(
                      bigText: BigText(text: "Liked Food",),
                      appIcon: AppIcon(
                        icon: Icons.favorite,
                        iconColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                        size: 40,
                        iconSize: 20,
                      ),
                    ),
                    AccountWidget(
                      bigText: BigText(text: "Rate Us..",),
                      appIcon: AppIcon(
                        icon: Icons.rate_review_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        size: 40,
                        iconSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
