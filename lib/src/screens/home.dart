import 'package:chat_in_groups/blocs/groups_bloc/groups_bloc.dart';
import 'package:chat_in_groups/src/constants/colors.dart';
import 'package:chat_in_groups/src/constants/images.dart';
import 'package:chat_in_groups/src/constants/spacings.dart';
import 'package:chat_in_groups/src/constants/texts.dart';
import 'package:chat_in_groups/src/screens/groups.dart';
import 'package:chat_in_groups/src/screens/user_profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

   @override
  State<StatefulWidget> createState() => _HomePage(); 
}

class _HomePage extends State<StatefulWidget> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getPagesPerIndex(index, context),
        bottomNavigationBar: SafeArea(
        maintainBottomViewPadding: true,
          child: ClipRRect(
            borderRadius: bottomBarRadius,
            clipBehavior: Clip.none,
            child: CurvedNavigationBar(
              animationDuration: const Duration(milliseconds: 300),
              onTap: (value) => {
                setState(() {
                  index = value;
                })
              },
              color: Colors.black,
              backgroundColor: backgroundColor,
              buttonBackgroundColor: Colors.black,
              height: 50,
              items: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.home_outlined, color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.message_outlined, color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.person_2_outlined , color: Colors.white),
                ),
              ]
            ),
          ),
        ),
    );
  }
  
}

Widget createCards(int index) {
  return Transform.translate(
    offset: const Offset(defaultPadding - 2, 0),
    child: Row(
      children: [
        Container(
            margin: const EdgeInsets.only(right: 20, bottom: 20),
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: cardRadius,
              boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16), // Shadow color
                blurRadius: 8, // Spread of the shadow
                offset: const Offset(2, 4), // Position of the shadow
              ),
            ],
            ),
            width: 180,
            padding: const EdgeInsets.only(top: 0, left: 10,right: 10,bottom: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(cardImages[index], width: 165, height: 150,),
                  Text(whyChooseUsCards[index]["heading"],
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600)),
                ])),
        lastWidget(index),
      ],
    ),
  );
}

Widget lastWidget(int index) {
  if (index == 4) {
    return const SizedBox(width: 40);
  } else {
    return const SizedBox(
      width: 0,
    );
  }
}

Widget createCourseCard(int index, BuildContext context) {
  return Transform.translate(
    offset: const Offset(defaultPadding - 2, 0),
    child: Row(
      children: [
        Container(
            margin: const EdgeInsets.only(right: 20, bottom: 20),
            decoration:   BoxDecoration(
              color: Colors.white,
              borderRadius: cardRadius,
              boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color
                blurRadius: 8, // Spread of the shadow
                offset: const Offset(2, 4), // Position of the shadow
              ),
              ]
            ),
            width: MediaQuery.of(context).size.width - 50,
            padding: const EdgeInsets.all(defaultPaddingMd),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: defaultPaddingXs, horizontal: defaultPaddingSm),
                    decoration: const BoxDecoration(
                      color:  Color.fromARGB(255, 234, 246, 255),
                      borderRadius: BorderRadius.all(inputBorderRadius),
                    ),
                    child: Text(courses[index]["duration"], style: const TextStyle(
                      fontSize: 10, color: Color.fromARGB(255, 113, 191, 255), fontWeight: FontWeight.w800
                    ),),
                  ),
                  const SizedBox(height: 15,),
                  Text(courses[index]["heading"],
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10,),
                  Text(courses[index]["text"],
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400,)),
                  const SizedBox(height: 20,),
                  const Text(coursesPerWeek,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87)),
                  const SizedBox(height: 12,),
                  SizedBox(
                    height: 8,
                    width: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index1) => getDaysPerWeek(context, index1, courses[index]["classes"])),
                  ),
                  const SizedBox(height: 18,),
                  const Text(userReview,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87)),
                  const SizedBox(height: 12,),
                  LinearProgressIndicator(
                    value: courses[index]["review"]/100,
                    minHeight: 6,
                    borderRadius: elevatedButtonRadius,
                    color:   const Color.fromARGB(255, 255, 213, 158),
                    backgroundColor: const Color.fromARGB(255, 236, 236, 236),
                  )
                ])),

        lastWidget(index),
      ],
    ),
  );
}

Widget getDaysPerWeek(BuildContext context, int index, int classes) {
  if (classes > index) {
    return Container(
      width: 30,
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 39, 183, 44)),
        borderRadius: sendButtonRadius
      ),
      child: Container(decoration: BoxDecoration(borderRadius: sendButtonRadius, color: const Color.fromARGB(255, 103, 255, 181)),),
    );
  } else {
    return Container(
      width: 30,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.451)),
        borderRadius: sendButtonRadius
      ),
    );
  }
}

Widget getPagesPerIndex(int index, BuildContext context) {
  switch (index) {
    case 0:
      return homePage(context);
    case 1:
      return const AllGroups();
      default:
        return const UserProfile();
  }
}

Widget homePage(context) {
  return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        homeTitle,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(homeSubtitle,
                          style: Theme.of(context).textTheme.labelSmall),
                    ]),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(homeSection1Title,
                        style: Theme.of(context).textTheme.labelLarge),
                  ),
                  const SizedBox(height: defaultColumnSpacingXs),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(homeSection1Subtitle,
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),
                  const SizedBox(height: defaultColumnSpacingLg),
                  SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) => createCards(index)),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Text(homeSection2Title,
                          style: Theme.of(context).textTheme.labelLarge),
                    ),
                    const SizedBox(height: defaultColumnSpacingXs),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: Text(homeSection2Subtitle,
                          style: Theme.of(context).textTheme.headlineSmall),
                    ),
                    const SizedBox(height: defaultColumnSpacingLg),
                    SizedBox(
                      height: 320,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) =>
                              createCourseCard(index, context)),
                    )
                  ],
                ),
              )
            ],
          ),
        );
}