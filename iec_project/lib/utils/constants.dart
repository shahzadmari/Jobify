import 'package:flutter/material.dart';

void dialog(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<void> showInformationDialog(BuildContext context) async {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  return await showDialog(
      context: context,
      builder: (context) {
        bool isChecked = false;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _textEditingController,
                      validator: (value) {
                        return value!.isNotEmpty ? null : "Enter any text";
                      },
                      decoration:
                          InputDecoration(hintText: "Please Enter Text"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Choice Box"),
                        Checkbox(
                            value: isChecked,
                            onChanged: (checked) {
                              setState(() {
                                isChecked = checked!;
                              });
                            })
                      ],
                    )
                  ],
                )),
            title: Text('Stateful Dialog'),
            actions: <Widget>[
              InkWell(
                child: Text('OK   '),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // Do something like updating SharedPreferences or User Settings etc.
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
      });
}

class ColorConstants {
  static const Color UiColor = Color.fromARGB(255, 13, 71, 161);
}
