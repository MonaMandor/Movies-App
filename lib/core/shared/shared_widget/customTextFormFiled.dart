// core/shared/shared_widget/customTextFormFiled.dart

// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:movie/core/constansts/context_extensions.dart';
import 'package:movie/core/theme/app_Theme.dart';
import 'package:movie/core/theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final Color? fillColor;
  final double? height;
  final double? width;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? errorMessage;
  final TextStyle? hintStyle;
  final bool? obscureText;
  final Widget? suffix;
  final Widget? prefix;

  const CustomTextField({
    Key? key,
    this.fillColor,
    this.height,
    this.width,
    this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.errorMessage,
    this.hintStyle,
    this.obscureText,
    this.suffix,
    this.prefix,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hasText = false;

  @override
  void initState() {
    super.initState();

    // Add a listener to the controller to detect changes in the text field
    widget.controller?.addListener(() {
      setState(() {
        hasText = widget.controller?.text.isNotEmpty ?? false;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    widget.controller?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText ?? false,
      style: AppTheme(context)
          .theme
          .textTheme
          .bodyLarge
          ?.copyWith(color: Colors.black),
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.red,
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        labelText: widget.labelText,
        prefixIcon: widget.suffix,
        suffixIcon: widget.prefix,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        contentPadding: EdgeInsets.only(
          bottom: context.propHeight(15),
          right: context.propWidth(20),
        ),
      ),
    );
  }
}
