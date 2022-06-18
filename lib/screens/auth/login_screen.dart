import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_video_stream/bloc/auth_bloc.dart';
import 'package:flutter_video_stream/core/app_constants.dart';
import 'package:flutter_video_stream/model/user_model.dart';
import 'package:flutter_video_stream/screens/widgets/custom_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showResendButton = false;
  final TextEditingController _phoneTC = TextEditingController();
  final TextEditingController _otpTC = TextEditingController();
  pageMode _view = pageMode.phone;
  PhoneAuthCredential credential;
  String _verificationId;
  int _resendToken;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool showLoader = false;
  final Duration _otpTimeOut = const Duration(seconds: 50);
  _sendOTPClick() async {
    try {
      if (_phoneTC.text.trim().isEmpty) {
        return CustomWidgets.showSnackbar(
            "Enter phone number to login", context);
      }
      setState(() {
        showLoader = true;
      });
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91 ${_phoneTC.text}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            CustomWidgets.showSnackbar("Verifying...", context);

            final UserCredential user =
                await auth.signInWithCredential(credential);
            if (user.user?.uid != null) {
              AppConstants.loggedUser = UserModel(
                  auth: Auth(
                    accessToken: user.credential.token.toString(),
                  ),
                  userData: UserData(
                    phoneNumber: user.user.phoneNumber,
                    email: user.user.email,
                    firstName: user.user.displayName,
                    imageURL: user.user.photoURL,
                  ));
              if (mounted) {
                setState(() {
                  showLoader = false;
                });
                CustomWidgets.showSnackbar("Logging in...", context);
                await AuthBloc().login(AppConstants.loggedUser, context);
              }
            }
          },
          timeout: _otpTimeOut,
          verificationFailed: (FirebaseAuthException e) {
            CustomWidgets.showSnackbar(e.message ?? "Error", context);
          },
          codeSent: (String verificationId, int resendToken) {
            CustomWidgets.showSnackbar("code sent", context);
            setState(() {
              _view = pageMode.otp;
              _verificationId = verificationId;
              _resendToken = _resendToken;
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            if (mounted) {
              CustomWidgets.showSnackbar("Timeout!", context);
              //show resend button
              setState(() {
                _verificationId = verificationId;
                showResendButton = !showResendButton;
              });
              //auto re-resend otp
              _verifyOtpClick();
            }
          },
          forceResendingToken: _resendToken);
      setState(() {
        showLoader = false;
      });
    } catch (e) {
      CustomWidgets.showSnackbar(e.toString(), context);
    }
  }

  _verifyOtpClick() async {
    if (_otpTC.text.trim().isEmpty) {
      return CustomWidgets.showSnackbar("Enter otp field", context);
    }
    try {
      setState(() {
        showLoader = true;
      });
      credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: _otpTC.text.trim());
      final UserCredential user = await auth.signInWithCredential(credential);

      if (user.user?.uid != null) {
        AppConstants.loggedUser = UserModel(
            auth: Auth(
              accessToken:
                  user.user?.uid == null ? "" : user.user.uid.toString(),
            ),
            userData: UserData(
              phoneNumber: user.user.phoneNumber,
              email: user.user.email,
              firstName: user.user.displayName,
              imageURL: user.user.photoURL,
            ));
        if (mounted) {
          setState(() {
            showLoader = false;
          });
          CustomWidgets.showSnackbar("Logging in...", context);
          await AuthBloc().login(AppConstants.loggedUser, context);
        }
      }
    } catch (e) {
      CustomWidgets.showSnackbar("OTP is wrong!", context);
      setState(() {
        showLoader = false;
        showResendButton = false;
      });
    }
  }

// 442412
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const SizedBox(
                height: 105,
              ),
              const FlutterLogo(
                size: 200,
              ),
              const SizedBox(
                height: 43,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  // readOnly: _view == pageMode.otp ? true : false,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                  controller: _phoneTC,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 14),
                      filled: true,
                      fillColor: const Color(0xffeff1f6),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      hintStyle: const TextStyle(color: Color(0xff313056)),
                      hintText: "Enter Phone number",
                      prefix: const Text(
                        "+91",
                        style: TextStyle(color: Color(0xff313056)),
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (_view == pageMode.otp)
                SizedBox(
                  height: 50,
                  child: TextField(
                    obscureText: true,
                    controller: _otpTC,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 14),
                      filled: true,
                      fillColor: const Color(0xffeff1f6),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      hintStyle: const TextStyle(color: Color(0xff313056)),
                      hintText: "Enter OTP",
                    ),
                  ),
                ),
              if (_view == pageMode.otp)
                const SizedBox(
                  height: 14,
                ),
              if (!showResendButton)
                showLoader
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red)),
                      )
                    : CustomWidgets.submitButton(
                        _view == pageMode.phone ? "Send OTP" : "Verity OTP",
                        onTap: () async {
                        if (!showLoader) {
                          _view == pageMode.otp
                              ? _verifyOtpClick()
                              : _sendOTPClick();
                        }
                      }),
              const SizedBox(
                height: 20,
              ),
              if (_view == pageMode.otp)
                showResendButton
                    ? CustomWidgets.submitButton("Resend OTP", onTap: () async {
                        setState(() {
                          _otpTC.clear();
                          _view = pageMode.phone;
                          showResendButton = false;
                        });
                        await _sendOTPClick();
                      })
                    : TweenAnimationBuilder<Duration>(
                        duration: _otpTimeOut,
                        tween: Tween(begin: _otpTimeOut, end: Duration.zero),
                        onEnd: () {
                          setState(() {
                            showResendButton = true;
                          });
                        },
                        builder: (BuildContext context, Duration value,
                            Widget child) {
                          final minutes = value.inMinutes;
                          final seconds = value.inSeconds % 60;
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text('$minutes:$seconds',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30)));
                        }),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum pageMode { phone, otp }
