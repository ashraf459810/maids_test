import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_test/core/widgets/button.dart';
import 'package:maids_test/core/widgets/loading.dart';
import 'package:maids_test/core/widgets/snackbar.dart';
import 'package:maids_test/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids_test/features/todos/presentation/pages/todos_page.dart';
import 'package:maids_test/injection.dart';
import '../../../../core/styles/styles.dart';
import '../../../../core/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc authBloc = sl<AuthBloc>();

  String? name;

  String? password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // Assigning GlobalKey<FormState> to the Form widget
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 83.h,
                ),
                Text(
                  'welcome',
                  style: Styles.titleTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 50.h,
                ),
                InputField(
                  hint: 'user name',
                  widget: const Icon(Icons.person_2_outlined),
                  getValue: (String? user) {
                    name = user;
                  },
                  textInputType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter your name';
                    }
                    // Add your mobile number validation logic here
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                InputField(
                  hint: 'password',
                  widget: const Icon(Icons.password),
                  textInputType: TextInputType.visiblePassword,
                  getValue: (String pass) {
                    password = pass;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password should be not empty';
                    }
                    if (value.length < 7) {
                      return 'password should be more than 6 character';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 60.h,
                ),
                BlocConsumer(
                  bloc: authBloc,
                  listener: (context, state) {
                    if (state is Error) {
                      CustomSnackBar.showError(context, state.error);
                    }
                    if (state is LoginSuccess) {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TodoListPage(),));
                    }
                  },
                  builder: (context, state) {
                    if (state is Loading) {
                      return const Center(child: LoadingWidget());
                    }
                    return AppButton(
                      value: 'login',
                      onClick: () {
                        // Check if the form is valid before calling the bloc event
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, call the bloc event
                          authBloc.add(LoginEvent(
                            password: password!,
                            userName: name!,
                          ));
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
