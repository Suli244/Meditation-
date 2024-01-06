import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meditation/features/home/models/home_model.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';

class HomeDetailPage extends StatelessWidget {
  const HomeDetailPage({super.key, required this.model});
  final HomeModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            expandedHeight: 415.h,
            leading: IconButton(
              iconSize: 24,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                padding: const EdgeInsets.only(
                  right: 2,
                ),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: AppColors.color658525,
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                model.image!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title!,
                    style: AppTextStylesMeditation.s26W600(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    model.time != null ? '${model.time!} minutes' : 'Benefits:',
                    style: AppTextStylesMeditation.s15W400(
                        color: AppColors.color50717C),
                  ),
                  SizedBox(height: 24.h),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: model.descriptions!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('\u2022',
                            style: AppTextStylesMeditation.s15W400(
                              color: AppColors.color50717C,
                            )),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            model.descriptions![index],
                            style: AppTextStylesMeditation.s15W400(
                              color: AppColors.color50717C,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
