import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:noteapp/core/constants/app_colors.dart';
import 'package:noteapp/core/constants/app_strings.dart';

class AppDialog {
  AppDialog._();

  static bool isOpen = false;

  static Future<void> confirm(
    BuildContext context, {
    bool barrierDismissible = true,
    required String message,
    String title = AppStrings.message,
    String confirmText = AppStrings.confirm,
    String cancelText = AppStrings.cancel,
    Function()? onConfirm,
    Function()? onCancel,
    Function? whenComplete,
  }) {
    dismiss(context);
    isOpen = true;

    return showDialog<dynamic>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            if (barrierDismissible) {
              dismiss(context);
            }
          },
          child: Container(
            color: Colors.black12,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13.r),
                child: Material(
                  child: Container(
                    color: Colors.white,
                    width: 255.w,
                    height: 125.h,
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              children: [
                                SizedBox(height: 18.h),
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  message,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.3.sp,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 0.8.h,
                          width: double.infinity,
                          color: Colors.black26,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Material(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: onCancel,
                                  child: Container(
                                    height: 40.h,
                                    alignment: Alignment.center,
                                    child: Text(
                                      cancelText,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 0.8.h,
                              height: 40.h,
                              color: Colors.black26,
                            ),
                            Expanded(
                              child: Material(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: onConfirm,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40.h,
                                    child: Text(
                                      confirmText,
                                      style: TextStyle(
                                        color: AppColors.textRedColor,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      isOpen = false;
      if (whenComplete != null) {
        whenComplete();
      }
    });
  }

  static Future<void> error(
    BuildContext context, {
    bool barrierDismissible = true,
    required String message,
    Function? whenComplete,
  }) {
    dismiss(context);
    isOpen = true;

    return showDialog<dynamic>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            if (barrierDismissible) {
              dismiss(context);
            }
          },
          child: Container(
            color: Colors.black12,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13.r),
                child: Material(
                  child: Container(
                    color: Colors.white,
                    width: 255.w,
                    height: 125.h,
                    child: Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              children: [
                                SizedBox(height: 18.h),
                                Text(
                                  AppStrings.error,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textRedColor,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  message,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.3.sp,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 0.8.h,
                          width: double.infinity,
                          color: Colors.black26,
                        ),
                        Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              dismiss(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40.h,
                              child: Text(
                                AppStrings.okay.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      isOpen = false;
      if (whenComplete != null) {
        whenComplete();
      }
    });
  }

  static Future<void> custom(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
    Function? whenComplete,
  }) {
    dismiss(context);
    isOpen = true;

    return showDialog<dynamic>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            if (barrierDismissible) {
              dismiss(context);
            }
          },
          child: Container(
            color: Colors.black12,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13.r),
                child: child,
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      isOpen = false;
      if (whenComplete != null) {
        whenComplete();
      }
    });
  }

  static Future<void> loading(
      BuildContext context, {
        required String message,
        Function? whenComplete,
      }) {
    dismiss(context);
    isOpen = true;

    return showDialog<dynamic>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          color: Colors.black12,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13.r),
              child: Material(
                child: Container(
                  color: Colors.white,
                  width: 255.w,
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.h,
                        height: 20.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.w,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        message,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.3.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      isOpen = false;
      if (whenComplete != null) {
        whenComplete();
      }
    });
  }

  static void dismiss(BuildContext context) {
    if (isOpen) {
      context.pop();
    }
  }
}
