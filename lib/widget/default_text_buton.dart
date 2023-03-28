import 'package:flutter/material.dart';

class DefaultTextButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const DefaultTextButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onTap, child: Text(text));
  }
}
