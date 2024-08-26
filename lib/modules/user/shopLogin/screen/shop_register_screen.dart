// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla_app/manager/cubits/register_cubit/register_cubit.dart';
import 'package:salla_app/network/local/cache_helper.dart';
import 'package:salla_app/modules/user/home/screen/home_screen.dart';
import 'package:salla_app/modules/user/shopLogin/screen/shop_login_screen.dart';
import 'package:salla_app/modules/user/shopLogin/widget/custom_button.dart';
import 'package:salla_app/modules/user/shopLogin/widget/custom_text_field.dart';
import 'package:salla_app/core/utils_class.dart';

class ShopRegisterScreen extends StatefulWidget {
  const ShopRegisterScreen({super.key});

  @override
  State<ShopRegisterScreen> createState() => _ShopRegisterState();
}

class _ShopRegisterState extends State<ShopRegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool isSecurePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel.status!) {
              print('status is ${state.registerModel.status}');
              print("msg is ${state.registerModel.message}");

              print("token isl ${state.registerModel.data?.token}");

              CacheHelper.saveData(
                      key: 'token',
                      value: state.registerModel.data?.token ?? "")
                  .then((value) {
                print('token saced');
                // String token = state.registerModel.data?.token ?? "";
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              });
            }
            Fluttertoast.showToast(
                msg: 'Login Success',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 18.0);
          } else {
            var model = RegisterCubit().registerModel;
            Fluttertoast.showToast(
                msg: model?.message.toString() ?? "error",
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
                        'Register',
                        style: Styles.login,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    CustomTextFormField(
                      controller: _nameController,
                      hint: 'Name',
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
                      controller: _phoneController,
                      hint: 'Phone Number',
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
                        text: 'Register',
                        backgroundColor: Styles.secondColor,
                        borderSideColor: Colors.transparent,
                        style: Styles.onboardingSubTitle,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            RegisterCubit.get(context).userRegister(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passController.text,
                                phone: _phoneController.text);
                            // LoginCubit.get(context).userLogin(
                            //     email: _emailController.text,
                            //     password: _passController.text);
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Not Valid',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 18.0);
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
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            'Already Have An Account?',
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
                                        const ShopLoginScreen()));
                          },
                          child: Text(
                            'Login',
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
      ),
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
