import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/core/constants/colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/core/helpers/extansions.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isActiv1 = false;
  bool isActiv2 = false;
  List<String> languages = [
    'English',
    'Arabic',
  ];
  String selectedLang = 'English';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Settings'.tr(context),
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: Icon(
          Icons.settings,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height / 5,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 20,
                    spreadRadius: 0,
                    blurStyle: BlurStyle.normal,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 14,
                          top: 14,
                          bottom: 8,
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(
                            'assets/images/logo1.png',
                          ),
                        ),
                      ),
                      Gap(20),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: Text(
                          'Sakina Application',
                          style: TextStyle(
                            fontFamily: poppins,
                            color: theredColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Color(0xffadadad)),
                  Gap(8),
                  //////////////////////////////////////////////////////////////
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        CustomLiustTileItem(
                          nameService: 'Language',
                          onTap: () {},
                          trailing: DropdownMenu(
                            initialSelection: selectedLang,
                            dropdownMenuEntries: languages.map(
                              (lang) {
                                return DropdownMenuEntry(
                                  value: lang,
                                  label: lang,
                                );
                              },
                            ).toList(),
                            onSelected: (value) {
                              selectedLang = value!;
                            },
                          ),
                        ),
                        CustomLiustTileItem(
                          onTap: () {},
                          nameService: 'Dark Mode',
                          trailing: Switch(
                            value: isActiv1,
                            onChanged: (val) {
                              isActiv1 = val;
                              setState(() {});
                            },
                          ),
                        ),
                        CustomLiustTileItem(
                          onTap: () {},
                          nameService: 'Notification',
                          trailing: Switch(
                            value: isActiv2,
                            onChanged: (val) {
                              isActiv2 = val;
                              setState(() {});
                            },
                          ),
                        ),
                        CustomLiustTileItem(
                          onTap: () {
                            print('Share app');
                          },
                          nameService: 'Share App',
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.share, size: 30),
                          ),
                        ),
                        CustomLiustTileItem(
                          onTap: () {},
                          nameService: 'FeedBack',
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.feedback_outlined, size: 30),
                          ),
                        ),
                        CustomLiustTileItem(
                          onTap: () {},
                          nameService: 'Contact',
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.email_outlined, size: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Color(0xffadadad)),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'More',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        fontFamily: poppins,
                        color: Color(0xffadadad),
                      ),
                    ),
                  ),
                  CustomLiustTileItem(
                    onTap: () {},
                    nameService: 'About Us',
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios_rounded, size: 26),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomLiustTileItem extends StatelessWidget {
  final String nameService;
  final Function()? onTap;
  final Widget? trailing;
  const CustomLiustTileItem({
    required this.nameService,
    this.onTap,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        onTap: onTap,
        title: Text(
          nameService,
          style: TextStyle(
            fontFamily: poppins,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}

// languages 
// dark mode
// notifications 
// share app 
// rate app 
// feedBack
// more .. about us 

