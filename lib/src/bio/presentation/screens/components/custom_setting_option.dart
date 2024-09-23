import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:flutter/material.dart';

class CustomSettingOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function() onTap;

  const CustomSettingOption({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.s),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 21.s, color: secondaryColor),
            SizedBox(width: 15.s),
            UIText.settingOption(title),
          ],
        ),
      ),
    );
  }
}
