import 'package:chat_firebase/common/values/values.dart';
import 'package:chat_firebase/common/widgets/widgets.dart';
import 'package:chat_firebase/screens/sign_in/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              width: 110.w,
              margin: EdgeInsets.only(top: 84.h),
              child: Column(
                children: [
                  Container(
                    height: 76.w,
                    width: 76.w,
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Stack(
                      children: [
                        Positioned(
                          child: Container(
                            height: 76.w,
                            decoration: BoxDecoration(
                              color: AppColors.primaryBackground,
                              boxShadow: const [Shadows.primaryShadow],
                              borderRadius: BorderRadius.circular(35),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Image.asset(
                            'assets/images/ic_launcher.png',
                            width: 76.w,
                            height: 76.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                    child: Text(
                      'Let\'s Chat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.thirdElement,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        height: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 280.h),
              width: 295.w,
              child: Column(
                children: [
                  Text(
                    'Sign In with social networks',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 30.h,
                      left: 50.h,
                      right: 50.h,
                    ),
                    child: btnFlatButtonWidget(
                      onPressed: () {
                        controller.handleSignIn();
                      },
                      width: 200.w,
                      height: 45.w,
                      title: 'Google Login',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
