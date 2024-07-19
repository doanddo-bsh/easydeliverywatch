// ignore_for_file: file_names

import 'package:async_preferences/async_preferences.dart';
import 'package:easydeliverywatch/regulation/initialization_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../module/darkThemeProvider.dart'; // ThemeProvider 파일 import

class SettingPage extends StatefulWidget {
  SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // dark mode

  // 정책 대응용
  final _initializationHelper = InitializationHelper();
  late final Future<bool> _future;

  @override
  void initState() {
    super.initState();

    _future = _isUnderGdpr();
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: FutureBuilder<bool>(
          future: _future,
          builder: (context, snapshot) {
            return ListView(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    top: 36.0,
                    right: 16.0,
                    bottom: 12.0,
                  ),
                  child: Text(
                    '설정',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(
                  indent: 12.0,
                  endIndent: 12.0,
                ),
                ListTile(
                  title: const Text('다크모드'),
                  onTap: () {
                    print('다크모드 되나?');
                    themeProvider.toggleThemeMode();

                    // widget.toggleThemeMode;
                    // print(toggleThemeMode);

                  },
                ),
                ListTile(
                  title: const Text('진통 주기 설정'),
                  onTap: () {
                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('진통 주기 설정하는 팝업'),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('기록 화면 설정'),
                  onTap: () {
                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('기록 화면 설정하는 팝업'),
                      ),
                    );
                  },
                ),

                // ListTile(
                //   title: const Text('Privacy Policy'),
                //   leading: const Icon(Icons.privacy_tip_rounded),
                //   visualDensity: VisualDensity.compact,
                //   onTap: (){
                //
                //   },
                // ),
                if (snapshot.hasData && snapshot.data == true)
                  Container(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      top: 36.0,
                      right: 16.0,
                      bottom: 12.0,
                    ),
                    child: Text(
                      'Privacy',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (snapshot.hasData && snapshot.data == true)
                  const Divider(
                    indent: 12.0,
                    endIndent: 12.0,
                  ),
                if (snapshot.hasData && snapshot.data == true)
                  ListTile(
                    title: const Text('Change privacy preferences'),
                    onTap: () async {
                      final scaffoldMessenger = ScaffoldMessenger.of(context);

                      final didChangePreferences =
                          await _initializationHelper.changePrivacyPreference();

                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text(
                            didChangePreferences
                                ? 'Your privacy choices have been updated'
                                : 'An error occurred while trying to change your '
                                    'privacy preferences',
                          ),
                        ),
                      );
                    },
                  )
              ],
            );
          }),
    );
  }

  Future<bool> _isUnderGdpr() async {
    final preferences = AsyncPreferences();
    return await preferences.getInt('IABTCF_gdprApplies') == 1;
  }
}
