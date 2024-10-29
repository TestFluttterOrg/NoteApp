import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/core/constants/app_colors.dart';

class AppInput extends StatelessWidget {
  final String hintText;
  final bool isValid;
  final Function(String)? onTextChanged;
  final TextInputType keyboardType;
  final String errorMessage;

  const AppInput({
    super.key,
    this.hintText = "",
    this.isValid = true,
    this.onTextChanged,
    this.keyboardType = TextInputType.text,
    this.errorMessage = "",
  });

  @override
  Widget build(BuildContext context) {
    final borderWidth = 1.2.w;
    final borderRadius = 5.0.r;
    final fontSize = 14.sp;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 40.h,
          child: Center(
            child: TextField(
              maxLines: 1,
              onChanged: onTextChanged,
              textAlign: TextAlign.center,
              cursorColor: AppColors.fieldCursorColor,
              cursorHeight: 15.h,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: fontSize,
              ),
              decoration: InputDecoration(
                isDense: true,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: AppColors.fieldHintTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: fontSize,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: errorMessage.isNotEmpty ? AppColors.fieldRedBorderColor : AppColors.fieldGrayBorderColor,
                    width: borderWidth,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: errorMessage.isNotEmpty ? AppColors.fieldRedBorderColor : AppColors.fieldBlueBorderColor,
                    width: borderWidth,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
          ),
        ),
        if (errorMessage.isNotEmpty)
          SizedBox(height: 5.h),
        if (errorMessage.isNotEmpty)
          Text(
            errorMessage,
            style: TextStyle(
              color: AppColors.fieldErrorTextColor,
              fontWeight: FontWeight.normal,
              fontSize: 13.sp,
            ),
          ),
      ],
    );
  }
}
