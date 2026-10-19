import 'package:banking_app/constants/animation_constant.dart';
import 'package:banking_app/constants/number_constant.dart';
import 'package:banking_app/constants/string_const.dart';
import 'package:banking_app/core/app_colors.dart';
import 'package:banking_app/core/app_textstyles.dart';
import 'package:banking_app/core/asset_res.dart';
import 'package:banking_app/core/models/bank_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BankCardWidget extends StatelessWidget {
  final BankCardModel card;
  final bool compact;
  final bool isSelected;
  final bool showDetails;
  final VoidCallback? onTap;
  final VoidCallback? onDetailsTap;

  const BankCardWidget({
    super.key,
    required this.card,
    this.compact = false,
    this.isSelected = false,
    this.showDetails = false,
    this.onTap,
    this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardFace = _buildCardFace();
    if (!compact) return GestureDetector(onTap: onTap, child: cardFace,);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AnimationConstant.interaction,
        curve: Curves.easeOutCubic,
        padding: .all(NumberConstant.selectCardPadding),
        decoration: BoxDecoration(
          borderRadius: .circular(NumberConstant.selectCardOuterRadius),
          border: .all(
            color: isSelected ? AppColors.selectionBorder : Colors.transparent,
            width: NumberConstant.selectCardBorderWidth,
          ),
        ),
        child: cardFace,
      ),
    );
  }

  Widget _buildCardFace() {
    final width = compact ? NumberConstant.selectCardSize : NumberConstant.bankCardWidth;
    final height = compact ? NumberConstant.selectCardSize : NumberConstant.bankCardHeight;
    final radius = compact ? NumberConstant.compactCardRadius : NumberConstant.cardRadius;
    final cardTypeLabelStyle =  compact
        ? (card.isDark ? AppTextStyles.cardTypeCompactLight : AppTextStyles.cardTypeCompact)
        : (card.isDark ? AppTextStyles.cardTypeLight : AppTextStyles.cardType);

    final cardLast4DigitsStyle = compact
        ? (card.isDark ? AppTextStyles.cardNumberCompactLight : AppTextStyles.cardNumberCompact)
        : (card.isDark ? AppTextStyles.cardNumberLight : AppTextStyles.cardNumber);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: card.isDark ? AppColors.darkCard : AppColors.primaryLime,
        borderRadius: .circular(radius),
      ),
      clipBehavior: .hardEdge,
      child: Stack(
        children: [
          _buildWatermark(),
          Padding(
            padding: .all(compact ? 12 : 17),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  crossAxisAlignment: .start,
                  children: [
                    if (compact)
                      _buildSelectionIndicator()
                    else
                      Text(StringConst.brandMark, style: card.isDark ? AppTextStyles.cardBrandLight : AppTextStyles.cardBrand,),
                    _buildNetworkBadge(),
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: .end,
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 0,
                        crossAxisAlignment: .start,
                        children: [
                          //card.typeLabel, cardTypeLabelStyle,
                          Text(card.typeLabel, style: cardTypeLabelStyle,),
                          Text(card.lastFour, style: cardLast4DigitsStyle,)
                          //card.lastFour, cardLast4DigitsStyle
                        ],
                      ),
                    ),
                    if (showDetails && !compact) _buildDetailsChip(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWatermark() {
    return Positioned(
      left: compact ? -28 : -31,
      top: compact ? -28 : (card.isDark ? -80 : -46),
      child: Transform.rotate(
        angle: card.isDark ? 0.98 : -0.21,
        child: Text(
          StringConst.watermark,
          style: AppTextStyles.watermark.copyWith(
            fontSize: card.isDark ? 42 : (compact ? 17 : 25),
            height: card.isDark ? 63 / 42 : null,
            color: card.isDark ? AppColors.watermarkDark : AppColors.watermarkLight,
          ),
          maxLines: 1,
          softWrap: false,
        ),
      ),
    );
  }

  Widget _buildSelectionIndicator() {
    return AnimatedScale(
      scale: isSelected ? 1.08 : 1,
      duration: AnimationConstant.interaction,
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        duration: AnimationConstant.interaction,
        curve: Curves.easeOutCubic,
        padding: .all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.selectionBorder : AppColors.scaffoldBg,
          shape: .circle,
          border: .all(
            color: isSelected ? AppColors.selectionBorder : AppColors.borderSoft,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkBadge() {
    if (card.network == .visa) return Text(StringConst.visa, style: AppTextStyles.visa,);
    final size = compact ? 16.8 : 24.0;
    final overlap = compact ? 12.0 : 17.0;
    return SizedBox(
      width: size + overlap,
      height: size,
      child: Stack(
        children: [
          Container(width: size, height: size, decoration: BoxDecoration(color: AppColors.mastercardRed, shape: .circle,),),
          Positioned(
            left: overlap,
            child: Opacity(
              opacity: 0.9,
              child: Container(width: size, height: size, decoration: BoxDecoration(color: AppColors.mastercardOrange, shape: .circle,),),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsChip() {
    return GestureDetector(
      onTap: onDetailsTap,
      child: Container(
        decoration: BoxDecoration(color: AppColors.white, borderRadius: .circular(20),),
        padding: .symmetric(horizontal: 14, vertical: 10),
        child: Row(
          spacing: 7,
          mainAxisSize: .min,
          children: [
            SvgPicture.asset(AssetRes.icDetails,),
            Text(StringConst.details, style: AppTextStyles.detailsChip,),
          ],
        ),
      ),
    );
  }
}