import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meditation/core/image/app_images.dart';
import 'package:meditation/features/useful_tips/logic/get_tips_cubit/get_tips_cubit.dart';
import 'package:meditation/features/useful_tips/widgets/tips_item_widget.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';
import 'package:meditation/widgets/app_unfocuser.dart';
import 'package:meditation/widgets/custom_app_bar.dart';

class UsefulTipsPage extends StatelessWidget {
  const UsefulTipsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return AppUnfocuser(
      child: BlocProvider(
        create: (context) => GetTipsCubit(),
        child: Scaffold(
          backgroundColor: AppColors.colordfe8cd,
          appBar: CustomAppBarMeditation(
            title: 'Useful Tips',
            titleTextStyle:
                AppTextStylesMeditation.s26W600(color: AppColors.color092A35),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Builder(
                    builder: (context) => TextFormField(
                      onChanged: (value) {
                        context.read<GetTipsCubit>().searchList(value);
                      },
                      cursorColor: AppColors.color658525,
                      style: AppTextStylesMeditation.s16W500(
                        color: AppColors.color50717C,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 21),
                          child: Image.asset(
                            AppImages.searchIcon,
                          ),
                        ),
                        suffixIconConstraints: BoxConstraints(
                          maxHeight: 21.5.h,
                        ),
                        hintText: 'Search',
                        hintStyle: AppTextStylesMeditation.s16W400(
                          color: AppColors.color50717C,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.color658525,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<GetTipsCubit, GetTipsState>(
                    builder: (context, state) {
                      return state.when(
                        loading: () => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        error: (error) => Center(
                          child: Text(error),
                        ),
                        success: (model) => ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: model.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8.h),
                          itemBuilder: (context, index) => TipsItemWidget(
                            model: model[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
