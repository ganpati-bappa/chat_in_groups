import 'package:chat_in_groups/blocs/add_user_bloc/add_user_bloc.dart';
import 'package:chat_in_groups/blocs/authentication_bloc/authentication_bloc_bloc.dart';
import 'package:chat_in_groups/blocs/groups_bloc/groups_bloc.dart';
import 'package:chat_in_groups/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:chat_in_groups/blocs/upload_files_bloc/upload_files_bloc.dart';
import 'package:chat_in_groups/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:chat_in_groups/firebase_options.dart';
import 'package:chat_in_groups/simple_bloc_observer.dart';
import 'package:chat_in_groups/src/screens/create_group.dart';
import 'package:chat_in_groups/src/screens/groups.dart';
import 'package:chat_in_groups/src/screens/home.dart';
import 'package:chat_in_groups/src/screens/login.dart';
import 'package:chat_in_groups/src/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(FirebaseUserRepository(), FirebaseChatGroupRepository()));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  final ChatGroupsRepository chatGroupsRepository;
  const MyApp(this.userRepository, this.chatGroupsRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationBlocBloc>(
          create: (context) => AuthenticationBlocBloc(myUserRepository: userRepository),
        ),
        RepositoryProvider<GroupsBloc>(
          create: (context) => GroupsBloc(chatGroupsRepository: chatGroupsRepository),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat In Groups',
          theme: themes.lightTheme,
          darkTheme: themes.darkTheme,
          themeMode: ThemeMode.light,
          home: BlocBuilder<AuthenticationBlocBloc, AuthenticationBlocState>(
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return MultiBlocProvider(providers: [
                BlocProvider<GroupsBloc>(
                  create: (context) => GroupsBloc(chatGroupsRepository: chatGroupsRepository,
                  user: state.user
                )),
                BlocProvider<UploadFilesBloc>(
                  create: (context) => UploadFilesBloc(userRepository: userRepository),
                ),
                BlocProvider<UserProfileBloc>(
                  create: (context) => UserProfileBloc(userRepository: userRepository)
                )
              ], 
              child: const Home());
              // return const Home();
            }
            else if (state.status == AuthenticationStatus.unauthenticated) {
               return BlocProvider<SignInBloc>(
                 create: (context) => SignInBloc(myUserRepository: userRepository),
                child: const Login()
               );
            }
            else {
              // return BlocProvider<SignInBloc>(
              //    create: (context) => SignInBloc(myUserRepository: userRepository),
              //   child: const Login()
              //  );
              return BlocProvider<GroupsBloc>(
                create: (context) => GroupsBloc(chatGroupsRepository: chatGroupsRepository,
                user: state.user),
                child: const AllGroups()
              );
            }
          }
        )
      )
    );
  }
}

