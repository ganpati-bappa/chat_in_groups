import 'package:chat_in_groups/blocs/chats_bloc/chat_bloc.dart';
import 'package:chat_in_groups/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_in_groups/src/constants/images.dart';
import 'package:chat_in_groups/src/constants/spacings.dart';
import 'package:chat_in_groups/src/constants/texts.dart';
import 'package:chat_in_groups/src/screens/chat_groups.dart';
import 'package:chat_in_groups/src/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => _SignUp();
}

class _SignUp extends State<StatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String errorMessage = "";
  RegExp emailValidator = RegExp(r"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$");
  RegExp passwordValidator = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
  RegExp phoneNoValidator = RegExp(r"^\+[1-9]{1}[0-9]{3,14}$") ;

  int validate(String email, String phoneNo, String password) {
    if (emailController.text.isEmpty) {
      return 0;
    } else if (!emailValidator.hasMatch(email)) {
      return 1;
    } else if (phoneNoController.text.isEmpty) {
      return 2;
    } else if (!phoneNoValidator.hasMatch(phoneNo)) {
      return 3;
    } else if (passwordController.text.isEmpty) {
      return 4;
    } else if (!passwordValidator.hasMatch(password)) {
      return 5;
    } else if (nameController.text.isEmpty) {
      return 6;
    }
    return 200;
  }
 
 @override
  Widget build(BuildContext context) {
    return  BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Home()));
        }
        else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message)
          ));
        } 
      },
      child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              const Image(image: AssetImage(loginPageImg)),
              Text(signUpWelcomeTitle, style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: defaultColumnSpacingXs),
              Text(signUpWelcomeSubtitle, style: Theme.of(context).textTheme.headlineMedium),
               Form(
                key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(defaultPaddingXs),
                  child: Column(
                    children: [
                      const SizedBox(height: defaultColumnSpacing),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
                          prefixIcon: Icon(Icons.email, size: inputIconsSize),
                          labelText: loginEmail,
                          hintText: loginEmail,
                          constraints: BoxConstraints(maxHeight: 45),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(inputBorderRadius)),
                              
                        ),
                      ),
                      const SizedBox(height: defaultColumnSpacingSm),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        controller: nameController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_2_rounded),
                            labelText: signUpName,
                            hintText: signUpName,
                          constraints: BoxConstraints(maxHeight: 45),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(inputBorderRadius)),
                          ),
                      ),
                      const SizedBox(height: defaultColumnSpacingSm),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        keyboardType: TextInputType.phone,
                        controller: phoneNoController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone_android_outlined),
                            labelText: signUpPhoneNo,
                            hintText: signUpPhoneNo,
                          constraints: BoxConstraints(maxHeight: 45),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(inputBorderRadius)),
                          ),
                      ),
                      const SizedBox(height: defaultColumnSpacingSm),
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration:  InputDecoration(
                            prefixIcon: const Icon(Icons.fingerprint),
                            labelText: loginPassword,
                            hintText: loginPassword,
                          constraints: const BoxConstraints(maxHeight: 45),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(inputBorderRadius)),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() => obscurePassword = !obscurePassword);
                              },
                              icon: (obscurePassword) ? const Icon(Icons.visibility_off) : const Icon(Icons.remove_red_eye_rounded),
                            )),
                      ),
                      const SizedBox(height: defaultColumnSpacingXXL),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (){
                             if (_formKey.currentState!.validate()) {
                              int errorStatus = validate(emailController.text, phoneNoController.text, passwordController.text);
                              if (errorStatus != 200) {
                                (context).read<SignUpBloc>().add(SignUpWrongFields(message: errorMessages[errorStatus]));
                              }
                              else if (context.read<SignUpBloc>().state is SignUpProcess) {
                                return;
                              }
                              else {
                                MyUser user = MyUser.empty;
                                user = user.copyWith(
                                  email: emailController.text,
                                  phoneNo: phoneNoController.text,
                                  name: nameController.text
                                );
                                (context).read<SignUpBloc>().add(SignUpRequired(
                                  user: user,
                                  password: passwordController.text
                                ));
                               }
                              }
                            },
                            child: Text(
                              signUp.toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        )
                    ],
                  )),
            )
            ]
          )
        )
      )
    ));
  }

}

Widget errorText(String errorMessage) {
  if (errorMessage.isEmpty) {
    return const SizedBox(height: 0);
  } else {
    return Text(errorMessage, style: const TextStyle(color: Colors.red));
  }
}