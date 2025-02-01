import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:smart_insti_app/components/borderless_button.dart';
import 'package:smart_insti_app/components/material_textformfield.dart';
import 'package:smart_insti_app/components/material_otp_box.dart';
import 'package:smart_insti_app/constants/constants.dart';
import 'package:smart_insti_app/provider/auth_provider.dart';

class GeneralLogin extends ConsumerWidget {
  GeneralLogin({super.key});

  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(authProvider.notifier).initializeOtpFocusNodes();

    return ResponsiveScaledBox(
      width: 411,
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: IntrinsicHeight(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Consumer(
                                    builder: (_, ref, __) => Text(
                                      ref.watch(authProvider).switchAuthLabel == AuthConstants.studentAuthLabel
                                          ? 'Student Login'
                                          : 'Faculty Login',
                                      style: const TextStyle(fontSize: 30, fontFamily: 'Jost'),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Consumer(
                                  builder: (_, ref, __) => !ref.watch(authProvider).emailSent
                                      ? Hero(
                                          tag: 'admin_page',
                                          child: BorderlessButton(
                                            onPressed: () => context.push('/login/admin_login'),
                                            backgroundColor: Colors.tealAccent.withOpacity(0.5),
                                            label: const Text('Admin'),
                                            splashColor: Colors.teal.shade700,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Consumer(
                              builder: (_, ref, __) => Form(
                                key: _emailFormKey,
                                child: MaterialTextFormField(
                                  hintText: "Email",
                                  validator: (value) => Validators.emailValidator(value),
                                  controller: ref.watch(authProvider).emailController,
                                  enabled: !ref.watch(authProvider).emailSent,
                                ),
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: ref.watch(authProvider).emailSent
                                  ? SizedBox(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              MaterialOTPBox(
                                                controller: ref.watch(authProvider).otpDigitControllers[0],
                                                focusNode: ref.watch(authProvider).otpFocusNodes[0],
                                                hintText: 'O',
                                              ),
                                              MaterialOTPBox(
                                                controller: ref.watch(authProvider).otpDigitControllers[1],
                                                focusNode: ref.watch(authProvider).otpFocusNodes[1],
                                                hintText: 'T',
                                                onChanged: (value) {
                                                  if (value != null && value.isEmpty) {
                                                    ref.watch(authProvider).otpFocusNodes[0].requestFocus();
                                                  }
                                                },
                                              ),
                                              MaterialOTPBox(
                                                controller: ref.watch(authProvider).otpDigitControllers[2],
                                                focusNode: ref.watch(authProvider).otpFocusNodes[2],
                                                hintText: 'P',
                                                onChanged: (value) {
                                                  if (value != null && value.isEmpty) {
                                                    ref.watch(authProvider).otpFocusNodes[1].requestFocus();
                                                  }
                                                },
                                              ),
                                              MaterialOTPBox(
                                                controller: ref.watch(authProvider).otpDigitControllers[3],
                                                focusNode: ref.watch(authProvider).otpFocusNodes[3],
                                                hintText: ':)',
                                                onChanged: (value) {
                                                  if (value != null && value.isEmpty) {
                                                    ref.watch(authProvider).otpFocusNodes[2].requestFocus();
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Consumer(
                                builder: (_, ref, __) => !ref.watch(authProvider).emailSent
                                    ? AnimatedToggleSwitch.dual(
                                        height: 45,
                                        spacing: 40,
                                        current: ref.watch(authProvider).switchAuthLabel,
                                        first: AuthConstants.studentAuthLabel,
                                        second: AuthConstants.facultyAuthLabel,
                                        onChanged: ref.watch(authProvider).emailSendingState == LoadingState.progress
                                            ? (value) {}
                                            : (value) => ref.read(authProvider.notifier).toggleAuthSwitch(),
                                        textBuilder: (value) => Text(value),
                                        styleBuilder: (value) => value == AuthConstants.studentAuthLabel
                                            ? ToggleStyle(
                                                indicatorColor: Colors.blue,
                                                backgroundColor: Colors.blue.shade100,
                                                borderColor: Colors.transparent,
                                              )
                                            : ToggleStyle(
                                                indicatorColor: Colors.green,
                                                backgroundColor: Colors.green.shade100,
                                                borderColor: Colors.transparent,
                                              ),
                                        iconBuilder: (value) => value == AuthConstants.studentAuthLabel
                                            ? const Icon(
                                                Icons.book_outlined,
                                                color: Colors.white,
                                              )
                                            : const Icon(
                                                Icons.portrait_rounded,
                                                color: Colors.white,
                                              ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Consumer(
                                  builder: (_, ref, __) => ref.watch(authProvider).emailSent
                                      ? Row(
                                          children: [
                                            SizedBox(
                                              height: 45,
                                              child: BorderlessButton(
                                                onPressed:
                                                    ref.watch(authProvider).emailSendingState == LoadingState.progress
                                                        ? () {}
                                                        : () async => ref.read(authProvider.notifier).sendOtp(context),
                                                backgroundColor: Colors.lightBlueAccent.withOpacity(0.5),
                                                label: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text('Resend'),
                                                    Consumer(
                                                      builder: (_, ref, __) {
                                                        return ref.watch(authProvider).emailSendingState ==
                                                                LoadingState.progress
                                                            ? Padding(
                                                                padding: const EdgeInsets.only(left: 15),
                                                                child: SizedBox(
                                                                  height: 20,
                                                                  width: 20,
                                                                  child: CircularProgressIndicator(
                                                                    strokeWidth: 2,
                                                                    color: Colors.blue.shade700,
                                                                  ),
                                                                ),
                                                              )
                                                            : const SizedBox.shrink();
                                                      },
                                                    )
                                                  ],
                                                ),
                                                splashColor: Colors.blue.shade700,
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Container(
                                              width: 45,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.tealAccent.withOpacity(0.5),
                                              ),
                                              child: GestureDetector(
                                                onTap: (ref.watch(authProvider).emailSendingState ==
                                                            LoadingState.progress ||
                                                        ref.watch(authProvider).loginProgressState ==
                                                            LoadingState.progress)
                                                    ? () {}
                                                    : () => ref.read(authProvider.notifier).clearControllers(),
                                                child: const Icon(
                                                  Icons.refresh,
                                                  color: Colors.teal,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : Container(),
                                ),
                                const Spacer(),
                                Consumer(
                                  builder: (_, ref, __) {
                                    if (ref.watch(authProvider).emailSent) {
                                      return SizedBox(
                                        height: 45,
                                        child: BorderlessButton(
                                          onPressed: (ref.watch(authProvider).emailSendingState ==
                                                      LoadingState.progress ||
                                                  ref.watch(authProvider).loginProgressState == LoadingState.progress)
                                              ? () {}
                                              : () async {
                                                  if (await ref
                                                          .read(authProvider.notifier)
                                                          .verifyOTPAndLogin(context) &&
                                                      context.mounted) {
                                                    ref.read(authProvider.notifier).clearControllers();
                                                    context.go('/');
                                                  }
                                                },
                                          backgroundColor: Colors.orangeAccent.withOpacity(0.5),
                                          label: Row(
                                            children: [
                                              const Text('Submit'),
                                              Consumer(
                                                builder: (_, ref, __) {
                                                  return ref.watch(authProvider).loginProgressState ==
                                                          LoadingState.progress
                                                      ? Padding(
                                                          padding: const EdgeInsets.only(left: 15),
                                                          child: SizedBox(
                                                            height: 20,
                                                            width: 20,
                                                            child: CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                              color: Colors.orange.shade700,
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox.shrink();
                                                },
                                              )
                                            ],
                                          ),
                                          splashColor: Colors.orange.shade700,
                                        ),
                                      );
                                    } else {
                                      return SizedBox(
                                        height: 45,
                                        child: BorderlessButton(
                                          onPressed: ref.watch(authProvider).emailSendingState == LoadingState.progress
                                              ? () {}
                                              : () async {
                                                  if (_emailFormKey.currentState!.validate()) {
                                                    ref.read(authProvider.notifier).sendOtp(context);
                                                  }
                                                },
                                          backgroundColor: Colors.orangeAccent.withOpacity(0.5),
                                          label: Row(
                                            children: [
                                              const Text('Login'),
                                              Consumer(
                                                builder: (_, ref, __) {
                                                  return ref.watch(authProvider).emailSendingState ==
                                                          LoadingState.progress
                                                      ? Padding(
                                                          padding: const EdgeInsets.only(left: 15),
                                                          child: SizedBox(
                                                            height: 20,
                                                            width: 20,
                                                            child: CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                              color: Colors.orange.shade700,
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox.shrink();
                                                },
                                              )
                                            ],
                                          ),
                                          splashColor: Colors.orange.shade700,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 35),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Smart Insti',
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
