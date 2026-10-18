import 'package:banking_app/constants/number_constant.dart';
import 'package:banking_app/constants/string_const.dart';
import 'package:banking_app/core/app_colors.dart';
import 'package:banking_app/core/app_data.dart';
import 'package:banking_app/core/app_textstyles.dart';
import 'package:banking_app/core/asset_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: .fromLTRB(NumberConstant.profileHorizontalPadding, 6, NumberConstant.profileHorizontalPadding, 0),
          child: SingleChildScrollView(
            padding: .only(bottom: 16),
            child: Column(
              children: [
                Text(StringConst.profile, style: AppTextStyles.screenTitle,),
                Padding(padding: .only(top: 20), child: _buildAvatar(),),
                Padding(padding: .only(top: 36), child: _buildPersonalInfoSection(),),
                Padding(padding: .only(top: 18), child: _buildAccountInfoSection(),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      clipBehavior: .none,
      children: [
        Container(
          padding: .all(5),
          decoration: BoxDecoration(color: AppColors.white, shape: .circle,),
          child: ClipOval(
            child: Image.asset(
              AppData.userProfile.avatar,
              width: NumberConstant.avatarSize,
              height: NumberConstant.avatarSize,
              fit: .cover,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 8,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: .circular(NumberConstant.actionButtonRadius),
                boxShadow: [
                  BoxShadow(color: AppColors.navShadow, blurRadius: 8, offset: const Offset(0, 2),),
                ],
              ),
              padding: .all(13.5),
              child: SvgPicture.asset(AssetRes.icEdit,),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection() {
    final profile = AppData.userProfile;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.white, borderRadius: .circular(NumberConstant.sectionRadius),),
      padding: .fromLTRB(20, 19, 20, 22),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(StringConst.personalInfo, style: AppTextStyles.sectionTitle,),
              GestureDetector(onTap: () {}, child: Text(StringConst.edit, style: AppTextStyles.actionLink,),),
            ],
          ),
          Padding(
            padding: .only(top: 21),
            child: Column(
              spacing: 17,
              children: [
                _buildInfoRow(icon: AssetRes.icPerson, label: StringConst.name, value: profile.name,),
                _buildInfoRow(icon: AssetRes.icEmail, label: StringConst.email, value: profile.email,),
                _buildInfoRow(icon: AssetRes.icPhone, label: StringConst.phoneNumber, value: profile.phone,),
                _buildInfoRow(icon: AssetRes.icAddress, label: StringConst.homeAddress, value: profile.address,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required String icon, required String label, required String value,}) {
    return Row(
      spacing: 11,
      crossAxisAlignment: .start,
      children: [
        Padding(padding: .only(top: 7), child: SvgPicture.asset(icon,),),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(label, style: AppTextStyles.infoLabel,),
              Text(value, style: AppTextStyles.infoValue,),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountInfoSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.white, borderRadius: .circular(NumberConstant.sectionRadius),),
      padding: .fromLTRB(20, 19, 20, 22),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(StringConst.accountInfo, style: AppTextStyles.sectionTitle,),
          Padding(
            padding: .only(top: 18),
            child: Opacity(
              opacity: 0.5,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(StringConst.accountType, style: AppTextStyles.accountLabel,),
                  Text(AppData.userProfile.accountType, style: AppTextStyles.accountValue,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
