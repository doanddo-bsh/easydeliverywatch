import 'package:easydeliverywatch/module/color_def.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final Container title, description;

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0,
        // backgroundColor: getColorFinal(context, color16, color16Dark),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              widget.title,
              const SizedBox(height: 15),
              widget.description,
              const SizedBox(height: 20),
              const Divider(
                height: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Center(
                    child: Text(
                      "확인",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
