import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meditation/core/premium/premium.dart';
import 'package:meditation/features/bottom_navigator/bottom_naviator_screen.dart';
import 'package:meditation/features/useful_tips/logic/tip_model.dart';
import 'package:meditation/features/useful_tips/tips_detail_page.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';
import 'package:shimmer/shimmer.dart';

class TipsItemWidget extends StatefulWidget {
  const TipsItemWidget({super.key, required this.model});
  final TipsModel model;

  @override
  State<TipsItemWidget> createState() => _TipsItemWidgetState();
}

class _TipsItemWidgetState extends State<TipsItemWidget> {
  bool byPremium = false;

  @override
  void initState() {
    getPremium();
    super.initState();
  }

  getPremium() async {
    byPremium = await PremiumMetitation.getPremium();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.model.premium && !byPremium) {
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const BottomNavigatorScreen(currindex: 3),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
              transitionDuration: const Duration(
                  seconds:
                      0), // Устанавливаем продолжительность анимации в 0 секунд
            ),
            (route) => false,
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TipsDetailPage(model: widget.model),
            ),
          );
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(16.h),
            height: 178.h,
            width: double.infinity,
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.model.image,
                  placeholder: (_, url) {
                    return SizedBox(
                      height: double.infinity,
                      width: 80.w,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.4),
                        highlightColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    );
                  },
                  imageBuilder: (_, imageProvider) {
                    return Container(
                      height: double.infinity,
                      width: 80.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.model.image,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.model.title,
                        style: AppTextStylesMeditation.s19W600(),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: Text(
                          widget.model.description,
                          style: AppTextStylesMeditation.s12W400(
                            color: AppColors.color50717C,
                          ),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (widget.model.premium && !byPremium)
            Container(
              height: 178.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.5),
              ),
              child: const Icon(Icons.lock),
            )
        ],
      ),
    );
  }
}
