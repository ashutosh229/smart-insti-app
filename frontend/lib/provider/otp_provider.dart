import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final otpProvider =
    StateNotifierProvider<OTPProvider, OTPState>((ref) => OTPProvider());

class OTPState {
  final FocusNode focusNode1;
  final FocusNode focusNode2;
  final FocusNode focusNode3;
  final FocusNode focusNode4;
  final TextEditingController emailController;
  final TextEditingController otpController1;
  final TextEditingController otpController2;
  final TextEditingController otpController3;
  final TextEditingController otpController4;

  final String dropdownValue;
  final bool showOTPFields;

  OTPState({
    required this.focusNode1,
    required this.focusNode2,
    required this.focusNode3,
    required this.focusNode4,
    required this.emailController,
    required this.otpController1,
    required this.otpController2,
    required this.otpController3,
    required this.otpController4,
    required this.dropdownValue,
    required this.showOTPFields,
  });
  OTPState copyWith({
    FocusNode? focusNode1,
    FocusNode? focusNode2,
    FocusNode? focusNode3,
    FocusNode? focusNode4,
    TextEditingController? emailController,
    TextEditingController? otpController1,
    TextEditingController? otpController2,
    TextEditingController? otpController3,
    TextEditingController? otpController4,
    String? dropdownValue,
    bool? showOTPFields,
  }) {
    return OTPState(
      focusNode1: focusNode1 ?? this.focusNode1,
      focusNode2: focusNode2 ?? this.focusNode2,
      focusNode3: focusNode3 ?? this.focusNode3,
      focusNode4: focusNode4 ?? this.focusNode4,
      emailController: emailController ?? this.emailController,
      otpController1: otpController1 ?? this.otpController1,
      otpController2: otpController2 ?? this.otpController2,
      otpController3: otpController3 ?? this.otpController3,
      otpController4: otpController4 ?? this.otpController4,
      dropdownValue: dropdownValue ?? this.dropdownValue,
      showOTPFields: showOTPFields ?? this.showOTPFields,
    );
  }
}

class OTPProvider extends StateNotifier<OTPState> {
  OTPProvider()
      : super(OTPState(
          focusNode1: FocusNode(),
          focusNode2: FocusNode(),
          focusNode3: FocusNode(),
          focusNode4: FocusNode(),
          emailController: TextEditingController(),
          otpController1: TextEditingController(),
          otpController2: TextEditingController(),
          otpController3: TextEditingController(),
          otpController4: TextEditingController(),
          dropdownValue: 'student',
          showOTPFields: false,
        ));

  void setShowOTPFields(bool value) {
    state = state.copyWith(showOTPFields: true);
  }

  void setDropdownValue(String value) {
    state = state.copyWith(dropdownValue: value);
  }
}
