import 'package:diplome_dima/ui/widgets/button.dart';
import 'package:diplome_dima/ui/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderInfoDialog extends StatefulWidget {
  final Function? sendData;
  final bool isTestDrive;

  const OrderInfoDialog({Key? key, this.sendData, this.isTestDrive = true}) : super(key: key);

  @override
  State<OrderInfoDialog> createState() => _OrderInfoDialogState();
}

class _OrderInfoDialogState extends State<OrderInfoDialog> {
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputField(
              hint: "Ваше имя",
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            InputField(
              hint: "Ваш телефон",
              controller: _phoneController,
            ),
            const SizedBox(height: 16),
            InputField(
              hint: "Ваша эл.почта",
              controller: _emailController,
            ),
            const SizedBox(height: 16),
            AppButton(
              text: "Отправить",
              onPressed: () async{
                final phone = _phoneController.text.trim();
                final email = _emailController.text.trim();
                final name = _nameController.text.trim();
                if(phone.isNotEmpty && email.isNotEmpty && name.isNotEmpty){
                  Navigator.pop(context);
                  await widget.sendData!(name, email, phone, widget.isTestDrive);
                }
                else{
                  Fluttertoast.showToast(msg: "Заполните поля");
                }
              }
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
