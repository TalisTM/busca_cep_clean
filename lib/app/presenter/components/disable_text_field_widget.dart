
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DisableTextFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  const DisableTextFieldWidget({required this.label, required this.text, Key? key}) : super(key: key);

  @override
  State<DisableTextFieldWidget> createState() => _DisableTextFieldWidgetState();
}

class _DisableTextFieldWidgetState extends State<DisableTextFieldWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(
      text: widget.text.isNotEmpty ? widget.text: "-"
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        enabled: widget.text.isNotEmpty,
        readOnly: true,
        controller: controller,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w700
        ),
        decoration: InputDecoration(
          suffixIcon: 
          widget.text.isNotEmpty
            ? IconButton(
                icon: Icon(
                  Icons.copy,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: widget.text));
                  BotToast.showText(text: "Campo copiado");
                } 
              )
            : null,
          labelText: widget.label,
          labelStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w700
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.6),
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.6),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.6),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}