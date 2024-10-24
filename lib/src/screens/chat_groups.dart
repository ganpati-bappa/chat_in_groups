import 'package:chat_in_groups/blocs/chats_bloc/chat_bloc.dart';
import 'package:chat_in_groups/blocs/groups_bloc/groups_bloc.dart';
import 'package:chat_in_groups/blocs/upload_files_bloc/upload_files_bloc.dart';
import 'package:chat_in_groups/src/constants/colors.dart';
import 'package:chat_in_groups/src/constants/images.dart';
import 'package:chat_in_groups/src/constants/spacings.dart';
import 'package:chat_in_groups/src/constants/texts.dart';
import 'package:chat_in_groups/src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:user_repository/user_repository.dart';

class IndividualChatGroup extends StatefulWidget {
  final String groupName;
  final String groupStatus;

  IndividualChatGroup(
      {required this.groupName, required this.groupStatus, super.key});

  @override
  State<IndividualChatGroup> createState() => _IndividualChatGroup();
}

class _IndividualChatGroup extends State<IndividualChatGroup> {
  late final String groupName;
  late final String groupStatus;

  

  @override
  void initState() {
    super.initState();
    groupName = widget.groupName;
    groupStatus = widget.groupStatus;
    (context)
        .read<ChatsBloc>()
        .add(ChatLoadingRequired(groupId: context.read<ChatsBloc>().groupRef));
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          titleSpacing: 0,
          title: Padding(
              padding: const EdgeInsets.only(
                  right: defaultPaddingXs,
                  top: defaultPaddingXs,
                  bottom: defaultPaddingXs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image(
                        image: AssetImage(googleIcons),
                        height: 40,
                        width: 40,
                      )),
                  const SizedBox(width: defaultColumnSpacingSm),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        groupName,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('Last updated on $groupStatus',
                          style: Theme.of(context).textTheme.headlineSmall)
                    ],
                  )
                ],
              )),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<ChatsBloc, ChatState>(
                  buildWhen: (context, state) => state is ChatLoaded,
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is ChatLoaded) {
                      if (state.messages.isNotEmpty) {
                        return Expanded(
                            child: ListView.builder(
                          reverse: true,
                          itemCount: state.messages.length,
                          itemBuilder: (context, index) {
                            return messageCard(state.messages[index], context);
                          },
                        ));
                      } else {
                        return const Expanded(
                          child: Center(
                            child: Text("Nahi bheja bhai kisi ne kuch abhi"),
                          ),
                        );
                      }
                    } else {
                      return const Expanded(
                        child: SizedBox(),
                      );
                    }
                  }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(defaultPaddingXs),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          maxLines: 5,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hoverColor: Colors.white,
                            focusColor: Colors.white,
                            filled: true,
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  CroppedFile? croppedFile;
                                  if (mounted) {
                                   croppedFile =
                                      await openImagePicker(
                                          context, ImageSource.camera);
                                  }
                                  setState(() {
                                    if (croppedFile?.path != null) {
                                      context.read<ChatsBloc>().add(
                                          SendImage(
                                              imagePath: croppedFile!.path));
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.grey,
                                )),
                            fillColor: Colors.white,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: inputChatText,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          if (_textEditingController.text.isNotEmpty) {
                            (context).read<ChatsBloc>().add(SendMessage(
                                message: _textEditingController.text.trim()));
                            _textEditingController.clear();
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.send, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

Widget messageCard(Messages message, BuildContext context) {
  if (message.sender?.id == context.read<GroupsBloc>().userRef.id) {
    return Column(
      children: [
        isLabelRequired(""),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPaddingSm, vertical: defaultPaddingXs),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 22, 16, 30),
                    borderRadius: BorderRadius.all(inputBorderRadius)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    message.message,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(
                    left: defaultPadding, right: defaultColumnSpacingXs),
                child: Text(
                  convertTimestampToString(
                      message.time!.microsecondsSinceEpoch)[1],
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  } else {
    return Column(
      children: [
        isLabelRequired(""),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPaddingSm, vertical: defaultPaddingXs),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: defaultPadding, left: defaultColumnSpacingXs),
                child: Text(
                  convertTimestampToString(
                      message.time!.microsecondsSinceEpoch)[1],
                  style: const TextStyle(fontSize: 10),
                ),
              ),
              Flexible(
                  child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(inputBorderRadius)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(message.senderName,
                          style: GoogleFonts.ptSerif(
                              color:
                                  userColors[message.senderName.length % 5])),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        message.message,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }
}

Widget isLabelRequired(String dayChangedLabel) {
  if (dayChangedLabel.isEmpty) {
    return const SizedBox();
  } else {
    return Center(
      child: Text(dayChangedLabel),
    );
  }
}
