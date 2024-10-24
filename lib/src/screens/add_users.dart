import 'package:chat_in_groups/blocs/add_user_bloc/add_user_bloc.dart';
import 'package:chat_in_groups/blocs/create_group_bloc/create_group_bloc.dart';
import 'package:chat_in_groups/blocs/groups_bloc/groups_bloc.dart';
import 'package:chat_in_groups/src/constants/spacings.dart';
import 'package:chat_in_groups/src/constants/texts.dart';
import 'package:chat_in_groups/src/screens/create_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:user_repository/user_repository.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({super.key});

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  List<bool> selected = List.generate(20, (index) => false);

  @override
  void initState() {
    super.initState();
    context.read<AddUserBloc>().add(UsersLoadingRequirred());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            addUsers,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          centerTitle: false,
        ),
        body: BlocBuilder<AddUserBloc, AddUserState>(
          buildWhen: (context, state) => (state is AddUsersLoaded),
          builder: (context, state) {
          if (state is UsersLoading) {
            return const SizedBox();
          } else if (state is AddUsersLoaded) {
            while (selected.length < state.users.length) {
              selected.add(false);
            }
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: const EdgeInsets.all(defaultPaddingSm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                ProfilePicture(
                                    name: state.users[index].name,
                                    radius: userDpRadius,
                                    fontsize: 13),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.users[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge),
                                    Text(state.users[index].email,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall)
                                  ],
                                ),
                              ],
                            ),
                            Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.black,
                                value: selected[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    selected[index] = !selected[index];
                                  });
                                }),
                          ],
                        ));
                  }),
            );
          } else {
            return const SizedBox();
          }
        }),
        persistentFooterButtons: [
          BlocBuilder<AddUserBloc, AddUserState>(
            builder: (context, state) {
            if (state is AddUsersLoaded) {
              List<MyUser> selectedUsers = state.users.asMap().entries.where((entry) => selected[entry.key]).map((entry) => entry.value).toList();
              return ElevatedButton(
                onPressed: () { 
                  if (selectedUsers.isNotEmpty) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => BlocProvider<CreateGroupBloc>(
                        create: (context) => CreateGroupBloc(chatGroupsRepository: (context).read<GroupsBloc>().chatGroupsRepository),
                        child: CreateGroup(users: selectedUsers),
                      )
                    ));
                  }
                },
                child: Text(next, style: Theme.of(context).textTheme.titleMedium,));
            }
            else {
              return ElevatedButton(
                onPressed: () {
                },
                child: Text(next, style: Theme.of(context).textTheme.titleMedium,));
            }
          }),
        ],
        );
  }
}
