import 'dart:io';

import 'package:chat_in_groups/blocs/upload_files_bloc/upload_files_bloc.dart';
import 'package:chat_in_groups/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:chat_in_groups/main.dart';
import 'package:chat_in_groups/src/constants/colors.dart';
import 'package:chat_in_groups/src/constants/spacings.dart';
import 'package:chat_in_groups/src/constants/texts.dart';
import 'package:chat_in_groups/src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<StatefulWidget> createState() => _UserProfile();
}

class _UserProfile extends State<StatefulWidget> {
  @override
  void initState() {
    super.initState();
    context.read<UserProfileBloc>().add(UserProfileLoadingRequired());
  }

void _openBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(topLeft: bottomSheetRadius, topRight: bottomSheetRadius)
          ),
          height: 190,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(photoPick,
                    style: Theme.of(context).textTheme.displayLarge),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          // CroppedFile? croppedFile = await openImagePicker(context, ImageSource.camera);
                          // setState(()  {
                          //     if (croppedFile?.path != null) {
                          //       context.read<UploadFilesBloc>().add(UploadImageEvent(pathId: croppedFile!.path));
                          //     }
                          // });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: sendButtonRadius,
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black87,
                            size: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(camera,
                          style: Theme.of(context).textTheme.headlineSmall)
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          // CroppedFile? croppedFile = await openImagePicker(context, ImageSource.gallery);
                          // setState(()  {
                          //     if (croppedFile?.path != null) {
                          //       context.read<UploadFilesBloc>().add(UploadImageEvent(pathId: croppedFile!.path));
                          //     }
                          // });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: sendButtonRadius,
                          ),
                          child: const Icon(
                            Icons.browse_gallery_outlined,
                            color: Colors.black87,
                            size: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(gallery,
                          style: Theme.of(context).textTheme.headlineSmall)
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.all(defaultPaddingXs),
          child: Text(userProfile,
              style: Theme.of(context).textTheme.displayLarge),
        ),
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoaded) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      getUserProfileDp(state.user, 25),
                      Positioned(
                          right: -2,
                          bottom: -2,
                          child: InkWell(
                            onTap: () {
                              _openBottomSheet(context);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 40,),
                Container(
                  padding: const EdgeInsets.only(left: defaultPaddingSm, right: defaultPaddingSm, bottom: defaultPaddingSm, top: defaultPaddingSm),
                  margin: const EdgeInsets.all(defaultPaddingXs),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0 ))
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person_2_rounded, size: 30, color: Color.fromARGB(255, 127, 127, 127),),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(signUpName, style: TextStyle(color: Colors.black54, fontSize: 12)),
                            Text(state.user.name, style: Theme.of(context).textTheme.bodyMedium,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: defaultPaddingSm, right: defaultPaddingSm, bottom: defaultPaddingSm, top: defaultPaddingSm),
                  margin: const EdgeInsets.all(defaultPaddingXs),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0 ))
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.phone_rounded, size: 30, color: Color.fromARGB(255, 127, 127, 127),),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(signUpPhoneNo , style: TextStyle(color: Colors.black54, fontSize: 12)),
                            Text(state.user.phoneNo, style: Theme.of(context).textTheme.bodyMedium,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: defaultPaddingSm, right: defaultPaddingSm, bottom: defaultPaddingSm, top: defaultPaddingSm),
                  margin: const EdgeInsets.all(defaultPaddingXs),
                  child: Row(
                    children: [
                      const Icon(Icons.email_rounded, size: 30, color: Color.fromARGB(255, 127, 127, 127),),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(loginEmail , style: TextStyle(color: Colors.black54, fontSize: 12)),
                            Text(state.user.email, style: Theme.of(context).textTheme.bodyMedium,)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Center(child: Text("Error aa gya bc phir se"));
          }
        },
      ),
    );
  }
}

Widget getUserProfileDp(MyUser user, double size) {
  if (user.picture == null || user.picture!.trim().isEmpty) {
    return ProfilePicture(
      fontsize: size,
      name: user.name,
      radius: size * 2,
    );
  } else {
    return ProfilePicture(
      fontsize: size,
      name: user.name,
      radius: size * 2,
      img: user.picture,
    );
  }
}
