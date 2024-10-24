import 'package:chat_in_groups/blocs/add_user_bloc/add_user_bloc.dart';
import 'package:chat_in_groups/blocs/chats_bloc/chat_bloc.dart';
import 'package:chat_in_groups/blocs/groups_bloc/groups_bloc.dart';
import 'package:chat_in_groups/src/constants/colors.dart';
import 'package:chat_in_groups/src/constants/spacings.dart';
import 'package:chat_in_groups/src/constants/texts.dart';
import 'package:chat_in_groups/src/screens/add_users.dart';
import 'package:chat_in_groups/src/screens/chat_groups.dart';
import 'package:chat_in_groups/src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:user_repository/user_repository.dart';

class AllGroups extends StatelessWidget {
  const AllGroups({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GroupsBloc>().add(ChatGroupsLoadingRequired());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Padding(
              padding: const EdgeInsets.all(defaultPaddingXs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: defaultColumnSpacingSm),
                  Text(groupsHeading,
                      style: Theme.of(context).textTheme.displayLarge)
                ],
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => AddUserBloc(chatGroupsRepository: (context).read<GroupsBloc>().chatGroupsRepository),
                            child: const AddUsers(),)));
                },
                icon: const Icon(
                  Icons.add,
                )),
            IconButton(
                onPressed: () {},
                icon:
                    const Icon(Icons.more_vert_outlined)),
          ],
        ),
        body: BlocBuilder<GroupsBloc, GroupsState>(
          buildWhen: (context, state) => (state is GroupsLoading || state is GroupsLoaded),
          builder: (context, state) {
            if (state is GroupsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is GroupsLoaded) {
              return Container(
                margin: const EdgeInsets.only(top: defaultPaddingXs),
                child: ListView.builder(
                itemCount: state.groups.length, itemBuilder: (context, index) => chatGroups(index,state.groups[index], context)),
              );
            }
            else {
              return const Center(
                child: Text("Error aa agya bc"),
              );
            }
          }
        ));
  }
}

Widget chatGroups(int index,Groups groups, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BlocProvider<ChatsBloc>(
          create: (context) => ChatsBloc(
            myChatRepository: context.read<GroupsBloc>().chatGroupsRepository,
            groupRef: context.read<GroupsBloc>().groupRef(groups.id), 
            senderRef: context.read<GroupsBloc>().userRef),
            child: IndividualChatGroup(groupName: groups.groupName, groupStatus: getDateLabel(convertTimestampToDateTime(groups.updatedTime.microsecondsSinceEpoch)),),
        )
      ));
    },
    child: Container(
      padding: const EdgeInsets.all(defaultPaddingXs),
      height: 60,
      margin: const EdgeInsets.only(left: defaultPaddingSm, right: defaultPaddingSm, bottom: defaultPaddingXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfilePicture(
            name: groups.groupName, 
            radius: userDpRadius, 
            fontsize: 16),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(groups.groupName, overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(
                  height: 2,
                ),
                Text('Managed by: ${groups.adminName}', overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ),
          getTextStatus(groups.updatedTime.microsecondsSinceEpoch),
        ],
      ),
    ),
  );
}
