import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meditation/features/useful_tips/logic/tip_model.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';

class TipsDetailPage extends StatelessWidget {
  const TipsDetailPage({super.key, required this.model});
  final TipsModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              expandedHeight: 415.h,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  model.image,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: AppTextStylesMeditation.s26W600(),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      model.description,
                      style: AppTextStylesMeditation.s15W400(
                        color: AppColors.color50717C,
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
