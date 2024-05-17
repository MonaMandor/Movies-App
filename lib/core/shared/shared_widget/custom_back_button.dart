// core/shared/shared_widget/custom_back_button.dart
/* // core/shared/shared_widget/custom_back_button.dart/* // core/shared/shared_widget/custom_back_button.dart
import 'package:flutter/material.dart';
import 'package:movie/core/constansts/asset_manger.dart';
import 'package:movie/core/constansts/context_extensions.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        Navigator.of(context).pop();
      },
      child: Container(
        width: context.propWidth(48),
        height: context.propWidth(48),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 15,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
            shape: BoxShape.circle),
        child: Center(child: Image.asset(AssetManger.iconsBack)),
      ),
    );
  }
}
  */ */