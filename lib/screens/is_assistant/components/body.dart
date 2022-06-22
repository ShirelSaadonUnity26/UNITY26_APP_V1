
import 'package:flutter/material.dart';
import 'package:unity26_app_v1/components/RoundedButon.dart';
import 'package:unity26_app_v1/screens/create_assistant/create_assistant.dart';
import 'package:unity26_app_v1/screens/home/home_screen.dart';

// This is the best practice


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _selectedType = 'yes';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
            SizedBox(
            height: size.height / 7.5,
              width: 100,
              child: Image.asset('assets/images/LogoMakr-9JpxYI.png')
            ),

              const Text('?האם אתה מעוניין לקחת חלק במערך הסיוע שלנו ?'),
              ListTile(
                leading: Radio<String>(
                  value: 'yes',
                  groupValue: _selectedType,
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                ),
                title: const Text('כן'),
              ),
              ListTile(
                leading: Radio<String>(
                  value: 'no',
                  groupValue: _selectedType,
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                ),
                title: const Text('לא'),
              ),
              SizedBox(
                  height: size.height / 2.5,
                  width: 450,
                  child: Image.asset('assets/images/older_woman.png')
              ),
              RoundedButton(
                  text: "סיום ",
                  press: () {
                    if (_selectedType == 'no') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ),
                      );
                    }
                    else {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CreateAssistant();
                          },
                        ),
                      );
                    }
                  }),

    SizedBox(height: size.height * 0.005),

            ])));
  }

}