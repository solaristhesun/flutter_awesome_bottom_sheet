import 'package:flutter/material.dart';

/// Custom color class for multiple theme color
class CustomSheetColor {
  final Color mainColor;
  final Color accentColor;
  final Color iconColor;
  final Color textColor;

  CustomSheetColor({
    required this.mainColor,
    required this.accentColor,
    required this.iconColor,
    this.textColor = Colors.white,
  });
}

class AwesomeBottomSheet {
  show({
    required BuildContext context,
    Text? title,
    required Text description,
    required CustomSheetColor color,
    required AwesomeSheetAction positive,
    EdgeInsets? contentPadding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
    EdgeInsets? actionPadding = const EdgeInsets.all(8.0),
    AwesomeSheetAction? negative,
    IconData? icon,
    double iconSize = 52,
    double titleFontSize = 24,
    double descriptionFontSize = 18,
    String fontFamily = 'circular',
    bool useRootNavigator = false,
    bool isDismissible = true,
    double radiusTopLeft = 10,
    double radiusTopRight = 10,
    double radiusBottomLeft = 0,
    double radiusBottomRight = 0,
  }) {
    showModalBottomSheet(
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useRootNavigator: useRootNavigator,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusTopLeft),
            topRight: Radius.circular(radiusTopRight),
            bottomLeft: Radius.circular(radiusBottomLeft),
            bottomRight: Radius.circular(radiusBottomRight),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: double.infinity,
                color: color.mainColor,
                padding: contentPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    title == null
                        ? Container()
                        : DefaultTextStyle(
                            style: TextStyle(
                              fontSize: titleFontSize,
                              color: color.textColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: fontFamily,
                            ),
                            textAlign: TextAlign.start,
                            child: title),
                    _buildContent(color, description, icon, fontFamily, descriptionFontSize, iconSize)
                  ],
                ),
              ),
              Container(
                padding: actionPadding,
                color: color.accentColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: _buildActions(positive, negative),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  /// return content widget
  _buildContent(CustomSheetColor color, Text description, IconData? icon, String fontFamily, double descriptionFontSize,
      double iconSize) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SingleChildScrollView(
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: DefaultTextStyle(
                        style: TextStyle(
                          fontSize: descriptionFontSize,
                          color: color.textColor,
                          fontFamily: fontFamily,
                        ),
                        child: description),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Icon(
                    icon,
                    size: iconSize,
                    color: color.iconColor,
                  )
                ],
              )
            : DefaultTextStyle(
                style: TextStyle(
                  fontSize: descriptionFontSize,
                  fontFamily: fontFamily,
                  color: color.textColor,
                ),
                child: description,
              ),
      ),
    );
  }

  /// action widget
  _buildActions(AwesomeSheetAction? positive, AwesomeSheetAction? negative) {
    List<AwesomeSheetAction> actions = [];

    // This order is important
    // It helps to place the positive at the right and the negative before
    if (negative != null) {
      actions.add(negative);
    }

    if (positive != null) {
      actions.add(positive);
    }

    return actions;
  }
}

/// action button widget

class AwesomeSheetAction extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color color;
  VoidCallback? onLongPress;

  AwesomeSheetAction({
    Key? key,
    required this.title,
    required this.onPressed,
    this.onLongPress,
    this.icon,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return icon == null
        ? TextButton(
            onPressed: onPressed,
            onLongPress: onLongPress,
            child: Text(
              title,
              style: TextStyle(
                color: color,
              ),
            ),
          )
        : TextButton.icon(
            onPressed: onPressed,
            onLongPress: onLongPress,
            label: Text(
              title,
              style: TextStyle(
                color: color,
              ),
            ),
            icon: Icon(
              icon,
              color: color,
            ),
          );
  }
}
