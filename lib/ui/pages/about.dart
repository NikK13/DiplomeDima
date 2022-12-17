import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 16),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/avtosalon.jpg"
              ),
              const SizedBox(height: 24),
              const Text(
                "2012 ООО ФелОкт-сервис,УНП 101179571\n220121 г. Минск, ул.Притыцкого, 60в, ком.2\nсвидетельство о государственной регистрации №0041147\nвыдано Минским горисполкомом 21.02.2011 г.\n\nРежим работы отдела продаж автомобилей (ул.Куприянова, 2А): пн.-пт.: 08.30-20.00, сб.: 09.00-18.00, вс.: 10:00-17.00\nРежим работы сервиса (ул.Куприянова, 2А): пн.-вс.: 08.00-20.00\nРежим работы сервиса (Притыцкого 60В): пн.-вс.: 08.00-20.00\n\nИнформация, представленная на сайте, носит справочный характер и не является публичной офертой. ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 42),
            ],
          ),
        ),
      ),
    );
  }
}
