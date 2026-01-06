import 'package:animated_login/animated_login.dart';
import 'package:clean_architecture/core/di/di.dart';
import 'package:clean_architecture/featuers/home/presentation/logic/products_cubit.dart';
import 'package:clean_architecture/featuers/login/data/models/login_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../logic/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  /// Simulates the multilanguage, you will implement your own logic.
  /// According to the current language, you can display a text message
  /// with the help of [LoginTexts] class.
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LanguageOption language = _languageOptions[1];
  AuthMode currentMode = AuthMode.login;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: AnimatedLogin(
                validatePassword: false,
                onLogin: LoginFunctions(context).onLogin,
                onForgotPassword: LoginFunctions(context).onForgotPassword,
                logo: Image.asset('assets/images/logo.gif'),
                // backgroundImage: 'images/background_image.jpg',
                signUpMode: SignUpModes.both,
                loginDesktopTheme: _desktopTheme,
                loginMobileTheme: _mobileTheme,
                loginTexts: _loginTexts,
                changeLanguageCallback: (LanguageOption? _language) {
                  if (_language != null) {
                    DialogBuilder(context).showResultDialog(
                      'Successfully changed the language to: ${_language.value}.',
                    );
                    if (mounted) setState(() => language = _language);
                  }
                },
                languageOptions: _languageOptions,
                selectedLanguage: language,
                initialMode: currentMode,
                onAuthModeChange: (AuthMode newMode) => currentMode = newMode,
              ),
            ),
            BlocListener<LoginCubit, LoginState>(
              child: SizedBox.shrink(),
              listener: (BuildContext context, state) {
                if (state is LoginSuccess) {
                  Navigator.of(context).pop();
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    text: "welcome" + state.loginData.name,
                    confirmBtnText: 'Save',
                    onConfirmBtnTap: () {
                      context.pushAndRemoveUntilTransition(
                        type: PageTransitionType.fade,
                        child: BlocProvider(
                          create: (context) => getIt<ProductsCubit>()..getAllProductsData(),
                          child: AllProducts(),
                        ),
                        predicate: (route) => false,
                      );
                    },
                    confirmBtnColor: Colors.green,
                  );
                }
                if (state is LoginLoading) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.loading,
                    title: 'Loading',
                    text: 'Fetching your data',
                  );
                } else if (state is LoginFailure) {
                  Navigator.of(context).pop();
                  QuickAlert.show(
                    context: context,
                    confirmBtnText: 'Save',

                    type: QuickAlertType.error,
                    title: state.code.toString(),
                    text: state.message,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  static List<LanguageOption> get _languageOptions => const <LanguageOption>[
    LanguageOption(
      value: 'Turkish',
      code: 'TR',
      iconPath: 'assets/images/tr.png',
    ),
    LanguageOption(
      value: 'English',
      code: 'EN',
      iconPath: 'assets/images/en.png',
    ),
  ];

  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *DESKTOP* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _desktopTheme => _mobileTheme.copyWith(
    // To set the color of button text, use foreground color.
    actionButtonStyle: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
    ),
    dialogTheme: const AnimatedDialogTheme(
      languageDialogTheme: LanguageDialogTheme(
        optionMargin: EdgeInsets.symmetric(horizontal: 80),
      ),
    ),
  );

  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *MOBILE* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _mobileTheme => LoginViewTheme(
    // showLabelTexts: false,
    backgroundColor: Colors.blue, // const Color(0xFF6666FF),
    formFieldBackgroundColor: Colors.white,
    formWidthRatio: 60,
    // actionButtonStyle: ButtonStyle(
    //   foregroundColor: MaterialStateProperty.all(Colors.blue),
    // ),
  );

  LoginTexts get _loginTexts =>
      LoginTexts(nameHint: _username, login: _login, signUp: _signup);

  /// You can adjust the texts in the screen according to the current language
  /// With the help of [LoginTexts], you can create a multilanguage scren.
  String get _username => language.code == 'TR' ? 'Kullanıcı Adı' : 'Username';

  String get _login => language.code == 'TR' ? 'Giriş Yap' : 'Login';

  String get _signup => language.code == 'TR' ? 'Kayıt Ol' : 'Sign Up';
}

class LoginFunctions {
  /// Collection of functions will be performed on login/signup.
  /// * e.g. [onLogin], [onSignup], [socialLogin], and [onForgotPassword]
  const LoginFunctions(this.context);

  final BuildContext context;

  /// Login action that will be performed on click to acti
  /// on button in login mode.
  Future<String?> onLogin(LoginData loginData) async {
    context.read<LoginCubit>().loginUser(
      LoginCredentials(email: loginData.email, password: loginData.password),
    );
    return null;
  }

  /// Action that will be performed on click to "Forgot Password?" text/CTA.
  /// Probably you will navigate user to a page to create a new password after the verification.
  Future<String?> onForgotPassword(String email) async {
    DialogBuilder(context).showLoadingDialog();
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pop();
    // You should determine this path and create the screen.
    // Navigator.of(context).pushNamed('/forgotPass');
    return null;
  }
}

class DialogBuilder {
  /// Builds various dialogs with different methods.
  /// * e.g. [showLoadingDialog], [showResultDialog]
  const DialogBuilder(this.context);

  final BuildContext context;

  /// Example loading dialog
  Future<void> showLoadingDialog() => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => WillPopScope(
      onWillPop: () async => false,
      child: const AlertDialog(
        content: SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.green,
              strokeWidth: 3,
            ),
          ),
        ),
      ),
    ),
  );

  /// Example result dialog
  Future<void> showResultDialog(String text) => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: SizedBox(
        height: 100,
        width: 100,
        child: Center(child: Text(text, textAlign: TextAlign.center)),
      ),
    ),
  );
}
