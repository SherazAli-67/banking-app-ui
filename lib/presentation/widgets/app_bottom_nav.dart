import 'package:banking_app/constants/number_constant.dart';
import 'package:banking_app/constants/string_const.dart';
import 'package:banking_app/core/app_colors.dart';
import 'package:banking_app/core/app_textstyles.dart';
import 'package:banking_app/core/asset_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final String avatarPath;

  const AppBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.97),
        borderRadius: .vertical(top: Radius.circular(NumberConstant.bottomNavTopRadius),),
        boxShadow: [
          BoxShadow(color: AppColors.navShadow, offset: const Offset(0, -5), blurRadius: 16,),
        ],
      ),
      padding: .fromLTRB(
        NumberConstant.bottomNavHorizontalPadding,
        NumberConstant.bottomNavTopPadding,
        NumberConstant.bottomNavHorizontalPadding,
        NumberConstant.bottomNavBottomPadding,
      ),
      child: Row(
        children: [
          Expanded(child: _buildNavItem(index: 0, icon: AssetRes.icHome, label: StringConst.home,),),
          Expanded(child: _buildNavItem(index: 1, icon: AssetRes.icMap, label: StringConst.map,),),
          Expanded(child: _buildNavItem(index: 2, icon: AssetRes.icTransfer, label: StringConst.transfer,),),
          Expanded(child: _buildNavItem(index: 3, icon: AssetRes.icSettings, label: StringConst.settings,),),
          Expanded(child: _buildProfileItem(),),
        ],
      ),
    );
  }

  Widget _buildNavItem({required int index, required String icon, required String label,}) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      behavior: .opaque,
      onTap: () => onTap(index),
      child: Column(
        spacing: 5,
        mainAxisSize: .min,
        children: [
          SvgPicture.asset(icon, colorFilter: .mode(isSelected ? AppColors.navActive : AppColors.navInactive, .srcIn),),
          Text(label, style: isSelected ? AppTextStyles.navLabelActive : AppTextStyles.navLabel,),
        ],
      ),
    );
  }

  Widget _buildProfileItem() {
    final isSelected = selectedIndex == 4;
    return GestureDetector(
      behavior: .opaque,
      onTap: () => onTap(4),
      child: Column(
        spacing: 5,
        mainAxisSize: .min,
        children: [
          Container(
            padding: .all(2),
            decoration: BoxDecoration(
              shape: .circle,
              border: .all(
                color: isSelected ? AppColors.primaryLime : Colors.transparent,
                width: NumberConstant.navAvatarBorderWidth,
              ),
            ),
            child: ClipOval(
              child: Image.asset(avatarPath, width: NumberConstant.navAvatarSize - 4, height: NumberConstant.navAvatarSize - 4, fit: .cover,),
            ),
          ),
          Text(StringConst.profile, style: isSelected ? AppTextStyles.navLabelActive : AppTextStyles.navLabel,),
        ],
      ),
    );
  }
}
