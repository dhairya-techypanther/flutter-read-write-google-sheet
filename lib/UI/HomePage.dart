import 'package:demo/API/UserSheetsAPI.dart';
import 'package:demo/Model/User.dart';
import 'package:demo/Widgets/ButtonWidgets.dart';
import 'package:flutter/material.dart';

class CreateSheetPage extends StatelessWidget {
  const CreateSheetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Google Sheets")),
        ),
        body: Container(
            color: Colors.white,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(32),
            child: ButtonWidget(
              text: "Submit",
              onClicked: () async {


                // final user = {
                //   UserFields.id: 1,
                //   UserFields.name: 'Dhairya',
                //   UserFields.email: 'Dhairya.shah@techypanther.com',
                //   UserFields.isBeginner: true,
                // };
                // await UserSheetsAPI.insert(user);
              },
            )));
  }
}
