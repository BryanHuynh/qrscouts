import 'package:flutter/material.dart';
import 'package:qrscout/services/collections.dart';
import 'package:settings_ui/settings_ui.dart';

import '../services/auth.dart';
import '../shared/bottom_nav.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(sections: [
        SettingsSection(tiles: [
          SettingsTile.navigation(
            title: const Text('Login Method'),
            leading: const Icon(Icons.person),
            trailing: Text(AuthService().getLoginMethod()),
          ),
          SettingsTile.navigation(
            title: const Text('sign out'),
            leading: const Icon(Icons.logout),
            onPressed: (BuildContext context) {
              AuthService().signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
          SettingsTile.navigation(
            title: const Text('Wipe collection'),
            leading: const Icon(Icons.delete),
            onPressed: (BuildContext context) {
              // add confirmation dialog
              showAlertDialog(context,
                  title: 'Wipe collection',
                  content: 'Are you sure you want to delete your collection?',
                  onOk: () {
                CollectionsService().deleteCollection();
              }, onCancel: () {});
              // CollectionsService().deleteCollection();
            },
          ),
        ])
      ]),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
    );
  }

  showAlertDialog(
    BuildContext context, {
    String title = '',
    String content = '',
    String okText = 'OK',
    String cancelText = 'Cancel',
    required Function onOk,
    required Function onCancel,
  }) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      onPressed: () {
        onCancel();
        Navigator.of(context).pop();
      },
      child: Text(cancelText),
    );
    Widget continueButton = ElevatedButton(
      onPressed: () {
        onOk();
        Navigator.of(context).pop();
      },
      child: Text(okText),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(
        content,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
