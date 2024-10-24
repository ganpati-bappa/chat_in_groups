import 'package:chat_in_groups/blocs/create_group_bloc/create_group_bloc.dart';
import 'package:chat_in_groups/blocs/groups_bloc/groups_bloc.dart';
import 'package:chat_in_groups/main.dart';
import 'package:chat_in_groups/src/constants/spacings.dart';
import 'package:chat_in_groups/src/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateGroup extends StatelessWidget {
  final List<MyUser> users;
  CreateGroup({required this.users, super.key});

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateGroupBloc, CreateGroupState>(
      listener: (context, state) {
        if (state is GroupSuccessfulyCreated) {
          context.read<GroupsBloc>().add(ChatGroupsLoadingRequired());
          Navigator.pop(context);
          Navigator.pop(context);
        } else if (state is GroupCreationFailed) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(createNewGroup,style: Theme.of(context).textTheme.displayLarge),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: IconButton(
                  onPressed: () {}, 
                  icon: const Icon(Icons.camera,)
                ),
              ),
              const SizedBox(width: 5),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: createGroupInputText,
                  constraints: BoxConstraints(maxHeight: 40, maxWidth: MediaQuery.of(context).size.width - 60),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.all(defaultPaddingSm),
            child: Column(
              children: [
                Text(selectGroupAdmin),
              ],
            ),
          )
        ],
      ),
      persistentFooterButtons: [
         ElevatedButton(
            style: const ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 10,vertical: 10))
            ),
            onPressed: () {
              context.read<CreateGroupBloc>().add(CreateNewGroup(users: users,groupName: _textEditingController.text));
            },
            child: Text(createNewGroup, style: Theme.of(context).textTheme.titleMedium,))
      ], 
    ));
  }
}