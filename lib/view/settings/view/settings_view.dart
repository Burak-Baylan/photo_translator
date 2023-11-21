import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_translator/global/constants/app_constant.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../global/constants/app_colors.dart';
import '../../../global/helper/open_link.dart';
import '../../../global/widgets/settings_view_premium_card.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        title: Text(
          'Settings',
          style: GoogleFonts.sourceSansPro(
            color: Colors.white,
            fontSize: context.height * .03,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingsViewPremiumCard(),
            buildSettingsCard(
              'Rate Us',
              CupertinoIcons.heart,
              () {},
            ),
            buildSettingsCard(
              'Contact Us',
              CupertinoIcons.paperplane,
              () => openLink(context, AppConstants.mailtoStr),
            ),
            buildSettingsCard(
              'Privacy Policy',
              CupertinoIcons.paperclip,
              () => openLink(context, AppConstants.privacyPolicyLink),
            ),
            buildSettingsCard(
              'Terms Of Use',
              CupertinoIcons.paperclip,
              () => openLink(context, AppConstants.termsOfUseLink),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSettingsCard(
    String title,
    IconData? icon,
    Function onPresssed,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: context.height * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.lightBackground2,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onPresssed(),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.02,
              vertical: context.height * 0.016,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: const Color.fromARGB(255, 73, 91, 162),
                  size: context.height * .04,
                ),
                SizedBox(width: context.width * 0.03),
                Text(
                  title,
                  style: GoogleFonts.sourceSansPro(
                    color: Colors.white,
                    fontSize: context.height * .02,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
