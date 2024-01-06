import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meditation/core/premium/premium.dart';
import 'package:meditation/features/bottom_navigator/bottom_naviator_screen.dart';
import 'package:meditation/features/home/home_detail_page.dart';
import 'package:meditation/features/home/models/home_model.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomeItem extends StatefulWidget {
  const HomeItem({
    super.key,
    required this.model,
    required this.index,
    required this.type,
  });
  final HomeModel model;
  final int index;
  final String type;

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  bool byPremium = false;
  late SharedPreferences pref;
  bool like = false;

  @override
  void initState() {
    getPremium();
    initLike();
    super.initState();
  }

  getPremium() async {
    byPremium = await PremiumMetitation.getPremium();
    setState(() {});
  }

  initLike() async {
    pref = await SharedPreferences.getInstance();
    like = pref.getBool('home_like_${widget.type}_${widget.index}') ?? false;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.model.premium! && !byPremium) {
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
              builder: (context) => HomeDetailPage(model: widget.model),
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
            padding: EdgeInsets.all(8.h),
            // height: 178.h,
            width: MediaQuery.of(context).size.width - 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 140.h,
                  width: MediaQuery.of(context).size.width - 48,
                  child: CachedNetworkImage(
                    imageUrl: widget.model.image!,
                    fit: BoxFit.fitWidth,
                    placeholder: (_, url) {
                      return SizedBox(
                        // height: double.infinity,
                        width: MediaQuery.of(context).size.width - 48,
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
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.model.title!,
                        style: AppTextStylesMeditation.s15W400(
                            color: AppColors.color092A35),
                      ),
                    ),
                    if (widget.model.time != null)
                      Text(
                        '${widget.model.time} minutes',
                        style: AppTextStylesMeditation.s12W400(
                            color: AppColors.color50717C),
                      ),
                  ],
                ),
                SizedBox(height: 8.h),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.model.descriptions!.length > 3
                      ? 3
                      : widget.model.descriptions!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022',
                          style: AppTextStylesMeditation.s12W400(
                            color: AppColors.color50717C,
                          )),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          widget.model.descriptions![index],
                          style: AppTextStylesMeditation.s12W400(
                            color: AppColors.color50717C,
                          ),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  like = !like;
                });
                pref.setBool('home_like_${widget.type}_${widget.index}', like);
              },
              child: Container(
                height: 32.h,
                width: 32.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white,
                ),
                child: Center(
                    child: Icon(
                  CupertinoIcons.heart_fill,
                  size: 16,
                  color: !like ? AppColors.colorAADC46 : Colors.red,
                )),
              ),
            ),
          ),
          if (widget.model.premium! && !byPremium)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Container(
                // height: 178.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withOpacity(0.5),
                ),
                child: const Center(child: Icon(Icons.lock)),
              ),
            )
        ],
      ),
    );
  }
}
