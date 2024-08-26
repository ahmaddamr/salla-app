import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla_app/manager/cubits/login_cubit/login_cubit.dart';
import 'package:salla_app/network/local/cache_helper.dart';
import 'package:salla_app/modules/user/home/screen/home_screen.dart';
import 'package:salla_app/modules/user/shopLogin/screen/shop_register_screen.dart';
import 'package:salla_app/modules/user/shopLogin/widget/custom_button.dart';
import 'package:salla_app/modules/user/shopLogin/widget/custom_text_field.dart';
import 'package:salla_app/core/utils_class.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({super.key});

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  // const ShopLoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  bool isSecurePassword = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              // ignore: avoid_print
              print(state.loginModel?.message);
              // ignore: avoid_print
              print(state.loginModel?.data?.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel?.data?.token)
                  .then(
                (value) {
                  // Navigator.pushReplacementNamed(context, 'HomeScreen');
                  String token = state.loginModel?.data?.token ?? "";
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
              );
              Fluttertoast.showToast(
                  msg: 'Login Success',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 18.0);
            } else {
              Fluttertoast.showToast(
                  msg:
                      'This credentials does not meet any of our records, please make sure you have entered the right credentials',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 18.0);
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Scaffold(
                // appBar: AppBar(),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/login.jpg'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                          'Login',
                          style: Styles.login,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      CustomTextFormField(
                        controller: _emailController,
                        hint: 'Email',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is empty';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (p0) {},
                        obscureText: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      CustomTextFormField(
                        suffixIcon: passwordShow(),
                        controller: _passController,
                        hint: 'Password',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is empty';
                          }
                          if (value.length < 5) {
                            return 'Password must be more than 5 letters';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (p0) {},
                        obscureText: isSecurePassword,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      CustomButton(
                          text: 'Login',
                          backgroundColor: Styles.secondColor,
                          borderSideColor: Colors.transparent,
                          style: Styles.onboardingSubTitle,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: _emailController.text,
                                  password: _passController.text);
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Not Valid',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                              // ignore: avoid_print
                              print('Not Valid');
                            }
                          }),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              'Dont Have An Account?',
                              style: Styles.onboardingSubTitle,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, 'ShopRegister');
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ShopRegisterScreen()));
                            },
                            child: Text(
                              'Register',
                              style: Styles.onboardingSubTitle
                                  .copyWith(color: Styles.secondColor),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget passwordShow() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSecurePassword = !isSecurePassword;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        child: Icon(
          isSecurePassword ? Icons.visibility : Icons.visibility_off,
          color: Colors.black,
        ),
      ),
    );
  }
}
