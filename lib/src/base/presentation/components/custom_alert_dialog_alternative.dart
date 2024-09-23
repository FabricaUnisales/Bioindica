import 'package:bioindica/src/core/ui_widgets/ui_widgets_lib.dart';
import 'package:flutter/material.dart';

///Alert Dialog com content sendo Widget
class CustomAlertDialogAlternative extends StatelessWidget {
  final String title;
  final Widget contentWidget;
  final VoidCallback? cancelAction;
  final VoidCallback confirmAction;

  const CustomAlertDialogAlternative({
    super.key,
    this.cancelAction,
    required this.confirmAction,
    required this.title,
    required this.contentWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: UIText.title(title),
      content: contentWidget,
      actions: [
        Visibility(
          visible: cancelAction != null,
          child: TextButton(
            onPressed: cancelAction,
            child: UIText.cancelButton('Cancelar'),
          ),
        ),
        TextButton(
          onPressed: confirmAction,
          child: UIText.confirmButton('Confirmar'),
        ),
      ],
    );
  }
}
