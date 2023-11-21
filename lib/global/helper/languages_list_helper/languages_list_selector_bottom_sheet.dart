// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_translator/core/extensions/context_extension.dart';
import 'package:photo_translator/global/constants/app_colors.dart';
import 'package:photo_translator/global/helper/languages_list_helper/languages_list_helper.dart';
import '../hive/hive_adapters/country_model_adapter.dart';

class LanguageSelectorBottomSheet {
  static Future<LanguageModel?> show(BuildContext context,
      {bool excludeAutomaticLanguage = false}) async {
    List<LanguageModel> countries = CountriesListHelper.countries;
    LanguageModel? selectedCountry;

    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return LanguagesListSelectorBody(
          countries: countries,
          excludeAutomaticLanguage: excludeAutomaticLanguage,
          onSelected: (LanguageModel country) {
            selectedCountry = country;
            context.pop;
          },
        );
      },
    );
    return selectedCountry;
  }
}

class LanguagesListSelectorBody extends StatefulWidget {
  LanguagesListSelectorBody(
      {super.key,
      required this.countries,
      required this.onSelected,
      this.excludeAutomaticLanguage = false});

  List<LanguageModel> countries;
  Function(LanguageModel country) onSelected;
  bool excludeAutomaticLanguage;

  @override
  State<LanguagesListSelectorBody> createState() =>
      _LanguagesListSelectorBodyState();
}

class _LanguagesListSelectorBodyState extends State<LanguagesListSelectorBody> {
  List<LanguageModel> countriesHere = [];

  @override
  void initState() {
    countriesHere = widget.countries;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height / 1.2,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: context.height * 0.03),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: context.width * 0.1,
              height: context.height * 0.008,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                color: Colors.grey.shade300,
              ),
            ),
          ),
          SizedBox(height: context.height * 0.04),
          Container(
            decoration: BoxDecoration(
              color: AppColors.lightBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: TextFormField(
              decoration: InputDecoration.collapsed(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white.withOpacity(.6)),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  countriesHere = CountriesListHelper.countries
                      .where((element) => element.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
          ),
          SizedBox(height: context.height * 0.03),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(
                horizontal: context.width * 0.04,
                vertical: context.height * 0.02,
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(height: 0),
                itemCount: countriesHere.length,
                itemBuilder: (context, index) {
                  if (widget.excludeAutomaticLanguage &&
                      countriesHere[index].code == 'auto') {
                    return const SizedBox();
                  }
                  LanguageModel country = countriesHere[index];
                  return Material(
                    color: Colors.transparent,
                    child: CupertinoButton(
                      onPressed: () => widget.onSelected(country),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          '${country.name} (${country.code})',
                          style: TextStyle(
                            fontSize: context.width * 0.05,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
