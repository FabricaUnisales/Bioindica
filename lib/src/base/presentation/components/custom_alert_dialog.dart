import 'package:bioindica/src/core/ui_widgets/ui_widgets_lib.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? cancelAction;
  final VoidCallback confirmAction;

  const CustomAlertDialog(
      {super.key, this.cancelAction, required this.confirmAction, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: UIText.title(title),
      content: UIText.body5(
        message,
        maxLines: 4,
      ),
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
