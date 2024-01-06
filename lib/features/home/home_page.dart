import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meditation/features/home/cubit/home_cubit.dart';
import 'package:meditation/features/home/widgets/home_item.dart';
import 'package:meditation/theme/app_colors.dart';
import 'package:meditation/theme/app_text_styles.dart';
import 'package:meditation/widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colordfe8cd,
      appBar: AppBar(
        title: const Text('Home'),
        titleTextStyle: AppTextStylesMeditation.s26W600(),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: AppColors.colordfe8cd,
        bottom: TabBar(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          indicatorColor: AppColors.color658525,
          unselectedLabelColor: AppColors.color50717C,
          onTap: (value) {
            setState(() {});
          },
          tabs: [
            Tab(
                child: Text('Meditation',
                    style: AppTextStylesMeditation.s19W600(
                        color: _tabController!.index == 0
                            ? AppColors.color658525
                            : AppColors.color50717C))),
            Tab(
                child: Text('Breathing',
                    style: AppTextStylesMeditation.s19W600(
                      color: _tabController!.index == 1
                          ? AppColors.color658525
                          : AppColors.color50717C,
                    ))),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _body('meditations'),
          _body('breathing'),
        ],
      ),
    );
  }

  BlocBuilder<HomeCubit, HomeState> _body(String json) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: HomeCubit()..getData(json),
      builder: (context, state) => state.map(
        loading: (data) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        error: (error) => Center(
          child: Text(error.message),
        ),
        loaded: (data) => SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: data.data.length,
            separatorBuilder: (context, index) => SizedBox(height: 8.h),
            itemBuilder: (context, index) => HomeItem(
              model: data.data[index],
              index: index,
              type: json,
            ),
          ),
        ),
      ),
    );
  }
}
