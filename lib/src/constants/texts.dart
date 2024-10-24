import 'package:flutter/material.dart';

const String loginPageWelcomeTitle = "Welcome Back";
const String loginPageWelcomeSubtitle = "Make it work, make it right, make it fast.";

const String loginEmail = "Email";
const String loginPassword = "Password";
const String forgotPassword = "Forget Password ?";
const String login = "Sign In";

const String addUserSnackBarText = "Please add one or more users to the group";
const String createNewGroup = "Create New Group";
const String createGroupInputText = "Please select a group name";
const String selectGroupAdmin = "Select a group admin among the selected users";
const String userProfile = "User Profile";
const String photoPick = "Pick a photo";
const String camera = "Camera";
const String gallery = "Gallery";

const String noAccount = "Don't have an account?";
const String createAccount = " Create Account";

const String or = "OR";
const String signWithGoogle = "Sign-in with Google";
const String cropImage = "Crop Image";

const String signUpWelcomeTitle = "Welcome";
const String signUpWelcomeSubtitle = "Let's sign up and join the community";
const String signUpPhoneNo = "Phone No";
const String signUpName = "Name";
const String signUp = "Sign Up";
const String homeTitle = "APS ";
const String homeSubtitle = "Online Academy";
const String homeSection1Title = "Our Key Features";
const String homeSection1Subtitle = "Apart from providing quality education, there are compelling reasons to choose us. Explore the key features that make us exceptional";
const String homeSection2Title = "Courses we offer";
const String homeSection2Subtitle = "Discover our comprehensive selection of courses designed to empower students with knowledge and skills for a brighter future";
const String next = "Next";

const List<String> errorMessages = ["Email field can not be empty",
"Invalid email format. Please re-check your email",
"Phone No can not be empty",
"Invalid Phone no, Please check if country code is present",
"Password can not be empty",
"Password is too weak. Please choose a strong password",
"Name can not be empty."
];

const String inputChatText = "Type your message";
const String addUsers = "Add Users";

const List<Map<String,dynamic>> whyChooseUsCards = [{
  "shadowColor" : Color(0xffD3E2F7),
  "cardColor": Color.fromARGB(255, 229, 250, 255),
  "heading": "Global Reach",
  "text": "Our virtual doors are open to students from every corner of the globe. No matter where you are, access quality education and join a diverse community of learners."
},
{
   "shadowColor" : Color(0xffD3E2F7),
  "cardColor": Color.fromARGB(255, 225, 233, 245),
  "heading": "Flexible Scheduling",
  "text": "Say goodbye to time zone constraints! Our classes are designed to accommodate students in all time zones, ensuring a seamless learning experience that fits your schedule."
},
{
   "shadowColor" : Color(0xffD3E2F7),
  "cardColor": Color.fromARGB(255, 225, 233, 245),
  "heading": "Comprehensive Curriculum",
  "text": "From academic subjects to enriching extracurricular activities, APS Online Academy offers a wide range of courses to suit every interest and passion. Discover new horizons and nurture your kids talents with us!"
},
{
   "shadowColor" : Color(0xffD3E2F7),
  "cardColor": Color.fromARGB(255, 225, 233, 245),
  "heading": "Expert Instructors",
  "text": "Make your kids learn from experienced educators who are passionate about helping them succeed. Our dedicated teachers provide personalized attention and guidance, fostering a supportive learning environment."
},
{
   "shadowColor" : Color(0xffD3E2F7),
  "cardColor": Color.fromARGB(255, 225, 233, 245),
  "heading": "Interactive Learning",
  "text": "Make your kids engage in dynamic virtual classrooms equipped with interactive tools and technologies. Let them collaborate with peers, participate in discussions, and unleash their creativity through engaging activities.!"
},

];

const List<Map<String,dynamic>> courses = [{
  "shadowColor" : Color(0xffD3E2F7),
  "cardColor": Color.fromARGB(255, 229, 250, 255),
  "heading": "Beginners Course",
  "text": "This engaging and interactive beginners course is designed for children aged 3.5 to 5 years, focusing on foundational skills in Environmental Studies (EVS), Phonics, and Maths.",
  "classes": 2,
  "duration": "45-50 mins",
  "review": 74,
},
{
   "shadowColor" : Color(0xffD3E2F7),
  "cardColor": Color.fromARGB(255, 225, 233, 245),
  "heading": "Juniors Course",
  "text": "Our Juniors course is thoughtfully designed for children aged 5 to 6 years, focusing on building essential skills in Environmental Studies (EVS), Phonics, and Maths. ",
  "classes": 3,
  "duration": "50-55 mins",
  "review": 83,
},
{
   "shadowColor" : Color(0xffD3E2F7),
  "cardColor": Color.fromARGB(255, 225, 233, 245),
  "heading": "Class 1 to 5 Course ",
  "text": "Our comprehensive course for students in Class 1 to 5, designed for children aged 5 to 13 years, focuses on developing critical thinking and foundational skills in Science, English, and Maths.",
  "classes": 5,
  "duration": "1 hour",
  "review": 75,
},
{
   "shadowColor" : Color(0xffD3E2F7),
  "cardColor": Color.fromARGB(255, 225, 233, 245),
  "heading": "Class 6 to 8 Course",
  "text": "Designed for students in Class 6 to 8, this course caters to learners aged 11 to 14 years, focusing on advancing their knowledge and skills in Science, English, and Maths. ",
  "classes": 5,
  "duration": "1 hour",
  "review": 79,
},
{
   "shadowColor" : Color(0xffD3E2F7),
  "cardColor": Color.fromARGB(255, 225, 233, 245),
  "heading": "Singing Classes: Harmonize Your Dreams",
  "text": "Unleash your vocal potential with our Singing Classes, designed for individuals of all ages and skill levels. Whether you're a complete beginner or an experienced vocalist, our program offers a nurturing and inspiring environment to help you develop your singing skills.",
  "classes": 2,
  "duration": "45-50 mins",
  "review": 91,
},

];

const String groupsHeading = "Classroom Groups";
const String coursesPerWeek = "Classes per week";
const String userReview = "User Reviews";