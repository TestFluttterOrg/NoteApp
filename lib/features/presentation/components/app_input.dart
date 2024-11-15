import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp/core/constants/app_colors.dart';

class AppInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isValid;
  final Function(String)? onTextChanged;
  final TextInputType keyboardType;
  final String errorMessage;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool readOnly;

  const AppInput({
    super.key,
    required this.controller,
    this.hintText = "",
    this.isValid = true,
    this.onTextChanged,
    this.keyboardType = TextInputType.text,
    this.errorMessage = "",
    this.maxLines = 1,
    this.minLines = 1,
    this.expands = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderWidth = 1.2.w;
    final borderRadius = 5.0.r;
    final fontSize = 15.sp;

    final fieldView = TextField(
      controller: controller,
      readOnly: readOnly,
      expands: expands,
      minLines: minLines,
      maxLines: maxLines,
      onChanged: onTextChanged,
      textAlign: TextAlign.start,
      textAlignVertical: expands ? TextAlignVertical.top : TextAlignVertical.center,
      cursorColor: AppColors.fieldCursorColor,
      cursorHeight: 15.h,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: fontSize,
      ),
      decoration: InputDecoration(
        filled: readOnly,
        fillColor: Colors.black12,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.fieldHintTextColor,
          fontWeight: FontWeight.normal,
          fontSize: fontSize,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: !isValid ? AppColors.fieldRedBorderColor : AppColors.fieldGrayBorderColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: !isValid
                ? AppColors.fieldRedBorderColor
                : readOnly
                    ? AppColors.fieldGrayBorderColor
                    : AppColors.fieldBlueBorderColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: expands ? CrossAxisAlignment.stretch : CrossAxisAlignment.start,
      children: [
        if (expands)
          Expanded(
            child: Container(
              child: fieldView,
            ),
          )
        else
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: Center(
              child: fieldView,
            ),
          ),
        if (errorMessage.isNotEmpty) SizedBox(height: 5.h),
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
