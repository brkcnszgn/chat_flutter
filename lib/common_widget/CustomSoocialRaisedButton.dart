import 'package:flutter/material.dart';

class SoocialLoginButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double buttonRadius;
  final double buttonHegiht;
  final Widget buttonIcon;
  final double textFontSize;
  final VoidCallback onPressed;

  const SoocialLoginButton(
      {Key key,
      @required this.buttonText,
      this.buttonColor: Colors.orange,
      this.textColor: Colors.white, //varasaılan değerler
      this.buttonRadius: 10,
      this.buttonHegiht: 40,
      this.buttonIcon,
      this.textFontSize: 16,
      @required this.onPressed})
      : assert(buttonText != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: buttonHegiht,
        child: RaisedButton(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Spreads, collection if
              if (buttonIcon != null) ...[
                buttonIcon,
                Text(
                  buttonText,
                  style: TextStyle(fontSize: textFontSize, color: textColor),
                ),
                Opacity(opacity: 0, child: buttonIcon),
              ],
              if (buttonIcon == null) ...[
                Container(),
                Text(
                  buttonText,
                  style: TextStyle(fontSize: textFontSize, color: textColor),
                ),
                Container(),
              ],
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(buttonRadius),
            ),
          ),
          onPressed: onPressed,
          color: buttonColor,
        ),
      ),
    );
  }
}

/*
Eski yöntem
 buttonIcon != null ? buttonIcon : Container(),
              Text(
                buttonText,
                style: TextStyle(fontSize: textFontSize, color: textColor),
              ),
              buttonIcon != null
                  ? Opacity(opacity: 0, child: buttonIcon)
                  : Container(),
 */
