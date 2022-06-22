import 'package:flutter/cupertino.dart';
import 'package:unity26_app_v1/service_class.dart';

import 'DataModel.dart';


class DataClass extends ChangeNotifier {
  DataModel? post;
  bool loading = false;

  getPostData() async {
    loading = true;
    post = (await getSinglePostData())!;
    loading = false;

    notifyListeners();
  }
}