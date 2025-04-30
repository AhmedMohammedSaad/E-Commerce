import 'package:advanced_app/core/color/colors.dart';
import 'package:advanced_app/core/localization/language_cubit.dart';
import 'package:advanced_app/core/localization/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'language'.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildLanguageSelector(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final languageCubit = context.read<LanguageCubit>();
        final currentLocale = context.locale;

        return Column(
          children: [
            ListTile(
              title: Text(
                'english'.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: Text(
                  'EN',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
              trailing: currentLocale.languageCode == LanguageManager.ENGLISH
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                languageCubit.setLanguage(context, LanguageManager.ENGLISH);
              },
            ),
            ListTile(
              title: Text(
                'arabic'.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: Text(
                  'AR',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
              trailing: currentLocale.languageCode == LanguageManager.ARABIC
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                languageCubit.setLanguage(context, LanguageManager.ARABIC);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                languageCubit.toggleLanguage(context);
              },
              icon: const Icon(Icons.swap_horiz),
              label: Text(
                'change_language'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
