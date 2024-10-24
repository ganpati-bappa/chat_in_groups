import 'package:chat_in_groups/blocs/authentication_bloc/authentication_bloc_bloc.dart';
import 'package:chat_in_groups/blocs/groups_bloc/groups_bloc.dart';
import 'package:chat_in_groups/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:chat_in_groups/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:chat_in_groups/src/screens/chat_groups.dart';
import 'package:chat_in_groups/src/screens/groups.dart';
import 'package:chat_in_groups/src/screens/home.dart';
import 'package:chat_in_groups/src/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:chat_in_groups/src/constants/images.dart';
import 'package:chat_in_groups/src/constants/spacings.dart';
import 'package:chat_in_groups/src/constants/texts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<StatefulWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  String errorMessage = "";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userRepository = context.read<SignInBloc>().myUserRepository;
    return BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BlocProvider<GroupsBloc>(
                  create: (context) => GroupsBloc(
                    chatGroupsRepository: FirebaseChatGroupRepository(), 
                    user: (context).read<AuthenticationBlocBloc>().state.user 
                  ),
                  child: const Home(),
              )
            ));
          } else if (state is SignInFailure) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message)
            ));
          }
        },
        child: Scaffold(
            body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultPaddingXs),
            child: Column(
              children: [
                const Image(image: AssetImage(loginPageImg)),
                Text(loginPageWelcomeTitle,
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: defaultColumnSpacingXs),
                Text(loginPageWelcomeSubtitle,
                    style: Theme.of(context).textTheme.headlineMedium),
                Form(
                  key: _formKey,
                  child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          const SizedBox(height: defaultColumnSpacingSm),
                          TextFormField(
                            style: Theme.of(context).textTheme.bodyMedium,
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(Icons.email),
                              labelText: loginEmail,
                              hintText: loginEmail,
                              constraints: BoxConstraints(maxHeight: 45),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(inputBorderRadius)),
                            ),
                          ),
                          const SizedBox(height: defaultColumnSpacingMd),
                          TextFormField(
                            controller: passwordController,
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.fingerprint),
                                labelText: loginPassword,
                                constraints: const BoxConstraints(maxHeight: 45),
                                hintText: loginPassword,
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(inputBorderRadius)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                    });
                                  },
                                  icon: const Icon(Icons.remove_red_eye_sharp),
                                )),
                          ),
                          const SizedBox(height: defaultColumnSpacingSm),
                          const Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: null,
                                  child: Text(forgotPassword,
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12)))),
                          const SizedBox(height: defaultColumnSpacing),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  (context).read<SignInBloc>().add(
                                      SignInRequired(
                                          email: emailController.text,
                                          password: passwordController.text));
                                },
                                child: Text(
                                  login.toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )),
                          Align(
                              heightFactor: 2,
                              child: Text(or,
                                  style:
                                      Theme.of(context).textTheme.labelLarge)),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                                icon: const Image(
                                  image: AssetImage(googleIcons),
                                  width: 20.0,
                                ),
                                onPressed: () {},
                                label: const Text(signWithGoogle)),
                          ),
                          const SizedBox(height: defaultColumnSpacingXXL),
                          TextButton(
                            onPressed: () {
                              if (context.read<SignInBloc>().state is SignInProgress) {
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                          create: (context) => SignUpBloc(
                                              myUserRepostiory: userRepository),
                                          child: const SignUp(),
                                        )),
                              );
                            },
                            child: Text.rich(
                                style: Theme.of(context).textTheme.bodyMedium,
                                const TextSpan(children: [
                                  TextSpan(text: noAccount),
                                  TextSpan(
                                      text: createAccount,
                                      style: TextStyle(color: Colors.blue))
                                ])),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        )));
  }
}
