import 'package:diplome_dima/data/utils/constants.dart';
import 'package:diplome_dima/ui/widgets/button.dart';
import 'package:diplome_dima/ui/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class OrderInfoDialog extends StatefulWidget {
  final Function? sendData;
  final bool isTestDrive;

  const OrderInfoDialog({Key? key, this.sendData, this.isTestDrive = true}) : super(key: key);

  @override
  State<OrderInfoDialog> createState() => _OrderInfoDialogState();
}

class _OrderInfoDialogState extends State<OrderInfoDialog> {
  final _dateStartController = TextEditingController();
  final _dateEndController = TextEditingController();

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
            Row(
              children: [
                Expanded(
                  child: InputField(
                    hint: "Начало",
                    controller: _dateStartController,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2024, 12, 31),
                      );
                      if(picked != null){
                        setState(() {
                          _dateStartController.text = DateFormat(dateFormat).format(picked);
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: InputField(
                    hint: "Конец",
                    controller: _dateEndController,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2024, 12, 31),
                      );
                      if(picked != null){
                        setState(() {
                          _dateEndController.text = DateFormat(dateFormat).format(picked);
                        });
                      }
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            AppButton(
              text: "Отправить",
              onPressed: () async{
                final phone = _phoneController.text.trim();
                final email = _emailController.text.trim();
                final name = _nameController.text.trim();
                final dateStart = _dateStartController.text.trim();
                final dateEnd = _dateEndController.text.trim();
                if(phone.isNotEmpty && email.isNotEmpty && name.isNotEmpty
                    && dateStart.isNotEmpty && dateEnd.isNotEmpty){
                  if(DateFormat(dateFormat).parse(dateEnd).isAfter(DateFormat(dateFormat).parse(dateStart))){
                    Navigator.pop(context);
                    await widget.sendData!(name, email, phone,
                    dateStart, dateEnd, widget.isTestDrive);
                  }
                  else{
                    Fluttertoast.showToast(msg: "Неправильно выбран промежуток даты");
                  }
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
