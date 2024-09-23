import 'package:bioindica/src/core/ui_widgets/ui_widgets_lib.dart';
import 'package:bioindica/src/core/utils/enums/snackbar_type.dart';
import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;
  final SnackBarType type;

  const CustomSnackBar.success({
    super.key,
    required this.message,
    this.type = SnackBarType.success,
  });

  const CustomSnackBar.info({
    super.key,
    required this.message,
    this.type = SnackBarType.info,
  });

  const CustomSnackBar.error({
    super.key,
    required this.message,
    this.type = SnackBarType.error,
  });

  const CustomSnackBar.conexaoError({
    super.key,
    this.message = "Verifique a conexão com a rede",
    this.type = SnackBarType.error,
  });

  const CustomSnackBar.warning({
    super.key,
    required this.message,
    this.type = SnackBarType.warning,
  });

  @override
  SnackBar build(BuildContext context) {
    return SnackBar(
      duration: _getDuration(),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(10.0.r),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0.r)),
      backgroundColor: _getBackgroundColor(),
      showCloseIcon: true,
      closeIconColor: labelColor,
      content: IntrinsicHeight(
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(10.0.r)),
                  color: _getColor(),
                ),
              ),
            ),
            Flexible(
                flex: 2,
                child: SizedBox(
                  width: 15.0.r,
                ),
            ),
            Flexible(
              flex: 2,
              child: Icon(_getIcon(), color: _getColor()),
            ),
            Flexible(
                flex: 2,
                child: SizedBox(
                  width: 15.0.r,
                ),
            ),
            Flexible(
              flex: 30,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0.r),
                child: UIText.snackbarMessage(message, maxLines: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SnackBar getSnackBar(BuildContext context) => build(context);

  Color _getColor() {
    switch (type) {
      case SnackBarType.success:
        return successColor;
      case SnackBarType.info:
        return secondaryColor;
      case SnackBarType.warning:
        return failureColor;
      case SnackBarType.error:
        return failureColor;
    }
  }

  Duration _getDuration() {
    switch (type) {
      case SnackBarType.success:
        return const Duration(seconds: 2);
      case SnackBarType.info:
        return const Duration(seconds: 5);
      case SnackBarType.warning:
        return const Duration(seconds: 5);
      case SnackBarType.error:
        return const Duration(seconds: 10);
    }
  }

  Color _getBackgroundColor() {
    switch (type) {
      case SnackBarType.success:
        return colorSuccessBackground;
      case SnackBarType.info:
        return colorWarningBackground;
      case SnackBarType.warning:
        return colorWarningBackground;
      case SnackBarType.error:
        return colorErrorBackground;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.info:
        return Icons.info;
      case SnackBarType.warning:
        return Icons.error;
      case SnackBarType.error:
        return Icons.cancel;
    }
  }
}

void showSnackBar(BuildContext context, CustomSnackBar customSnackbar) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(customSnackbar.getSnackBar(context));
}
