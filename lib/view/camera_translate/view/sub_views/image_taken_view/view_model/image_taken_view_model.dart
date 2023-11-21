import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'image_taken_view_model.g.dart';

class ImageTakenViewModel = _ImageTakenViewModelBase with _$ImageTakenViewModel;

abstract class _ImageTakenViewModelBase with Store {
  // set context
  late BuildContext contextt;
  void setContext(BuildContext context) => contextt = context;
}