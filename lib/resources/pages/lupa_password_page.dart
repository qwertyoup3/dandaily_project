import 'package:nylo_framework/nylo_framework.dart';
import 'package:dandaily/app/controllers/lupa_password_controller.dart';

class LupaPasswordPage extends NyStatefulWidget<LupaPasswordController> {
  static const path = '/lupa-password';

  LupaPasswordPage({super.key}) : super(child: () => _LupaPasswordPageState());
}

class _LupaPasswordPageState extends NyState<LupaPasswordPage> {
  /// [LupaPasswordController] controller
  LupaPasswordController get controller => widget.controller;
}
