import 'package:flutter/material.dart';
import 'package:dlgc_hymnal/core/assets/assets.dart';
import 'package:dlgc_hymnal/features/features.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectLanguage(String language) {
    if (language == 'yoruba') {
      // Navigate to home screen for Yoruba
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => 
              const HomeScreen(initialIndex: 0),
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              ),
            );
          },
        ),
      );
    } else {
      // Navigate to coming soon screen for English
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => 
              const ComingSoonScreen(),
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.1),
              Colors.white,
              AppColors.primary.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                
                // Header Section
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          children: [
                            // App Icon
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.library_music,
                                size: 40,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 24),
                            
                            // Title
                            Text(
                              'Select Your Language',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            
                            // Subtitle
                            Text(
                              'Choose your preferred language for hymns\nYan ede ti o fe ka orin mimo si',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const Spacer(),

                // Language Options
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          // English Option
                          _buildLanguageCard(
                            language: 'English',
                            nativeText: 'English Hymns',
                            subtitle: 'Coming Soon',
                            flag: '🇺🇸',
                            isAvailable: false,
                            onTap: () => _selectLanguage('english'),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Yoruba Option
                          _buildLanguageCard(
                            language: 'Yorùbá',
                            nativeText: 'Orin Mimọ́ Yorùbá',
                            subtitle: 'Available Now',
                            flag: '🇳🇬',
                            isAvailable: true,
                            onTap: () => _selectLanguage('yoruba'),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const Spacer(),

                // Footer
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            'Divine Love Gospel Church',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black45,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Version 1.0.0',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard({
    required String language,
    required String nativeText,
    required String subtitle,
    required String flag,
    required bool isAvailable,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isAvailable ? Colors.white : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isAvailable 
                ? AppColors.primary.withOpacity(0.3)
                : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isAvailable 
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Flag/Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isAvailable 
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  flag,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Language Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isAvailable ? Colors.black87 : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    nativeText,
                    style: TextStyle(
                      fontSize: 14,
                      color: isAvailable ? Colors.black54 : Colors.black38,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: isAvailable 
                          ? Colors.green.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isAvailable ? Colors.green : Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Arrow
            Icon(
              Icons.arrow_forward_ios,
              color: isAvailable ? AppColors.primary : Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}