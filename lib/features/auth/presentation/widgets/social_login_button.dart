import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SocialLoginButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.textSecondary.withValues(alpha: 0.3)),
      ),
      child: IconButton(
        icon: _getIcon(),
        onPressed: onPressed,
      ),
    );
  }

  Widget _getIcon() {
    if (icon == 'google') {
      return Icon(Icons.g_mobiledata, size: 32, color: AppColors.textPrimary);
    } else if (icon == 'apple') {
      return Icon(Icons.apple, size: 32, color: AppColors.textPrimary);
    }
    return Icon(Icons.login, size: 32, color: AppColors.textPrimary);
  }
}
