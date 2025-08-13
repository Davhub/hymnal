import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dlgc_hymnal/core/assets/assets.dart';
import 'package:dlgc_hymnal/core/services/settings_service.dart';
import 'package:dlgc_hymnal/core/providers/theme_provider.dart';
import 'package:dlgc_hymnal/core/providers/text_size_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _showDailyHymn;
  late bool _enableNotifications;
  late bool _autoPlay;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    setState(() {
      _showDailyHymn = SettingsService.showDailyHymn;
      _enableNotifications = SettingsService.enableNotifications;
      _autoPlay = SettingsService.autoPlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, TextSizeProvider>(
      builder: (context, themeProvider, textSizeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Settings',
              style: TextStyle(
                fontSize: textSizeProvider.titleText,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            backgroundColor: AppColors.primary,
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      // Appearance Section
                      _buildSectionHeader('Appearance', textSizeProvider),
                      _buildSwitchTile(
                        title: 'Dark Mode',
                        subtitle: 'Switch between light and dark theme',
                        value: themeProvider.isDarkMode,
                        icon: Icons.dark_mode,
                        textSizeProvider: textSizeProvider,
                        onChanged: (value) async {
                          await themeProvider.toggleTheme();
                          _showSnackBar('Dark mode ${value ? 'enabled' : 'disabled'}');
                        },
                      ),
                      _buildSliderTile(
                        title: 'Text Size',
                        subtitle: 'Adjust reading text size',
                        value: textSizeProvider.textSize,
                        min: 12.0,
                        max: 24.0,
                        divisions: 6,
                        icon: Icons.text_fields,
                        textSizeProvider: textSizeProvider,
                        onChanged: (value) async {
                          await textSizeProvider.updateTextSize(value);
                        },
                      ),
                      const Divider(height: 32),

                      // Preferences Section
                      _buildSectionHeader('Preferences', textSizeProvider),
                      _buildSwitchTile(
                        title: 'Show Daily Hymn',
                        subtitle: 'Display featured hymn on home screen',
                        value: _showDailyHymn,
                        icon: Icons.today,
                        textSizeProvider: textSizeProvider,
                        onChanged: (value) async {
                          setState(() {
                            _showDailyHymn = value;
                          });
                          await SettingsService.setShowDailyHymn(value);
                          _showSnackBar('Daily hymn ${value ? 'enabled' : 'disabled'}');
                        },
                      ),
                      _buildSwitchTile(
                        title: 'Notifications',
                        subtitle: 'Receive daily hymn reminders (Coming Soon)',
                        value: _enableNotifications,
                        icon: Icons.notifications,
                        textSizeProvider: textSizeProvider,
                        onChanged: (value) async {
                          setState(() {
                            _enableNotifications = value;
                          });
                          await SettingsService.setEnableNotifications(value);
                          _showSnackBar('Notifications ${value ? 'enabled' : 'disabled'} - Feature coming soon!');
                        },
                      ),
                      _buildSwitchTile(
                        title: 'Auto-play Audio',
                        subtitle: 'Automatically play hymn audio when available (Coming Soon)',
                        value: _autoPlay,
                        icon: Icons.music_note,
                        textSizeProvider: textSizeProvider,
                        onChanged: (value) async {
                          setState(() {
                            _autoPlay = value;
                          });
                          await SettingsService.setAutoPlay(value);
                          _showSnackBar('Auto-play ${value ? 'enabled' : 'disabled'} - Feature coming soon!');
                        },
                      ),
                      const Divider(height: 32),

                      // Support Section
                      _buildSectionHeader('Support', textSizeProvider),
                      _buildActionTile(
                        title: 'Rate App',
                        subtitle: 'Help us improve by rating the app',
                        icon: Icons.star_outline,
                        textSizeProvider: textSizeProvider,
                        onTap: () {
                          _showSnackBar('Thank you for your feedback!');
                        },
                      ),
                      _buildActionTile(
                        title: 'Share App',
                        subtitle: 'Tell others about this hymnal',
                        icon: Icons.share,
                        textSizeProvider: textSizeProvider,
                        onTap: () {
                          _showSnackBar('Sharing functionality coming soon!');
                        },
                      ),
                      _buildActionTile(
                        title: 'Contact Us',
                        subtitle: 'Send feedback or report issues',
                        icon: Icons.email_outlined,
                        textSizeProvider: textSizeProvider,
                        onTap: () {
                          _showContactDialog(textSizeProvider);
                        },
                      ),
                      _buildActionTile(
                        title: 'About',
                        subtitle: 'App information and credits',
                        icon: Icons.info_outline,
                        textSizeProvider: textSizeProvider,
                        onTap: () {
                          _showAboutDialog(textSizeProvider);
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                // Footer with responsive text
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark 
                        ? Colors.grey[800] 
                        : Colors.grey[50],
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? Colors.grey[700]! 
                            : Colors.grey[200]!,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Version 1.0.0',
                        style: TextStyle(
                          fontSize: textSizeProvider.mediumText,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '© ${DateTime.now().year} Divine Love Gospel Church',
                        style: TextStyle(
                          fontSize: textSizeProvider.smallText,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, TextSizeProvider textSizeProvider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: textSizeProvider.titleText,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required TextSizeProvider textSizeProvider,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title, 
        style: TextStyle(
          fontSize: textSizeProvider.largeText,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      subtitle: Text(
        subtitle, 
        style: TextStyle(
          fontSize: textSizeProvider.mediumText,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      trailing: Switch(
        value: value,
        activeColor: AppColors.primary,
        onChanged: onChanged,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildSliderTile({
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required IconData icon,
    required TextSizeProvider textSizeProvider,
    required ValueChanged<double> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title, 
        style: TextStyle(
          fontSize: textSizeProvider.largeText,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle, 
            style: TextStyle(
              fontSize: textSizeProvider.mediumText,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 8),
          // Preview text that changes size in real-time
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Sample hymn text preview',
              style: TextStyle(
                fontSize: value, // Use the current slider value for preview
                fontWeight: FontWeight.normal,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            activeColor: AppColors.primary,
            label: '${value.round()}pt',
            onChanged: onChanged,
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildActionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required TextSizeProvider textSizeProvider,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title, 
        style: TextStyle(
          fontSize: textSizeProvider.largeText,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      subtitle: Text(
        subtitle, 
        style: TextStyle(
          fontSize: textSizeProvider.mediumText,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      onTap: onTap,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _showAboutDialog(TextSizeProvider textSizeProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.music_note,
                              size: 40,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Divine Love Gospel Hymnal',
                            style: TextStyle(
                              fontSize: textSizeProvider.headingText,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Version 1.0.0',
                            style: TextStyle(
                              fontSize: textSizeProvider.mediumText,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildAboutSection(
                      'Our Mission',
                      'To provide a comprehensive digital hymnal that brings believers together in worship and praise. Our app contains carefully curated hymns that have blessed generations of Christians worldwide.',
                      textSizeProvider,
                    ),
                    _buildAboutSection(
                      'Features',
                      '• Complete hymn collection with lyrics\n• Search and filter functionality\n• Favorite hymns for quick access\n• Daily featured hymns\n• Category-based browsing\n• Share hymns with others',
                      textSizeProvider,
                    ),
                    _buildAboutSection(
                      'About Divine Love Gospel Church',
                      'Divine Love Gospel Church is committed to spreading the Gospel through music and worship. We believe that hymns are a powerful way to connect with God and build community among believers.',
                      textSizeProvider,
                    ),
                    _buildAboutSection(
                      'Development Team',
                      'This app was developed with love and dedication by our technical team to serve the body of Christ. We continue to work on improvements and new features.',
                      textSizeProvider,
                    ),
                    _buildAboutSection(
                      'Contact Information',
                      'Email: info@divinelovegospel.org\nWebsite: www.divinelovegospel.org\nPhone: 080 0000 0000',
                      textSizeProvider,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        '© ${DateTime.now().year} Divine Love Gospel Church\nAll rights reserved.',
                        style: TextStyle(
                          fontSize: textSizeProvider.smallText,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection(String title, String content, TextSizeProvider textSizeProvider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: textSizeProvider.titleText,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: textSizeProvider.mediumText,
              fontWeight: FontWeight.normal,
              height: 1.6,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(TextSizeProvider textSizeProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Contact Us', 
          style: TextStyle(
            fontSize: textSizeProvider.titleText,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We\'d love to hear from you!',
              style: TextStyle(
                fontSize: textSizeProvider.largeText,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 16),
            _buildContactItem(Icons.email, 'info@divinelovegospel.org', textSizeProvider),
            _buildContactItem(Icons.phone, '080 0000 0000', textSizeProvider),
            _buildContactItem(Icons.web, 'www.divinelovegospel.org', textSizeProvider),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(
                fontSize: textSizeProvider.mediumText,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text, TextSizeProvider textSizeProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text, 
              style: TextStyle(
                fontSize: textSizeProvider.mediumText,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}