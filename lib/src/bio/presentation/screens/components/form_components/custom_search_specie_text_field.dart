import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:bioindica/src/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CustomSearchSpecieTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final List<String> species;

  const CustomSearchSpecieTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.species,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UIText.label4(labelText),
        SizedBox(height: 5.s),
        SizedBox(
          height: SizerUtil.height < 600 ? 55.r : null,
          child: TextFormField(
            onTap: () async {
              await Get.toNamed(ScreensRoutes.searchSpecie, arguments: species)!.then((selectedSpecie) {
                controller.text = selectedSpecie ?? species.first;
              });
            },
            readOnly: true,
            showCursor: false,
            keyboardType: TextInputType.none,
            controller: controller,
            cursorColor: secondaryColor,
            style: textFieldStyle,
            minLines: 1,
            maxLines: 3,
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              hintStyle: textFieldHintStyle,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              enabledBorder: _buildDefaultBorder(),
              disabledBorder: _buildDefaultBorder(),
              focusedBorder: _buildDefaultBorder(borderWidth: 2.2),
              contentPadding: const EdgeInsets.all(10),
              suffixIcon:
                  const Icon(Icons.arrow_drop_down, color: bodyTextColor),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildDefaultBorder({double borderWidth = 1.2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(color: bodyTextColor, width: borderWidth),
    );
  }
}
