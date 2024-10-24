import 'package:chat_in_groups/src/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:user_repository/user_repository.dart';

String getDateLabel(DateTime timestamp) {
  String dayLabel = "";
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime yesterday = today.subtract(const Duration(days: 1));

  if (timestamp.isAfter(today)) {
    dayLabel = "Today";
  } else if (timestamp.isAfter(yesterday) && timestamp.isBefore(today)) {
    dayLabel = "Yesterday";
  } else {
    dayLabel = "${timestamp.day}/${timestamp.month}/${timestamp.year}";
  }
  return dayLabel;
}

DateTime convertTimestampToDateTime(int timestamp) {
  return DateTime.fromMicrosecondsSinceEpoch(timestamp);
}

List<String> convertTimestampToString(int timestamp) {
  // Convert the timestamp to DateTime
  DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp);

  // Format the DateTime to a string
  String formattedTime = DateFormat('yyyy-MM-dd kk:mm').format(dateTime);
  return formattedTime.split(' ');
}

Widget getTextStatus(int timestamp) {
  if (getDateLabel(convertTimestampToDateTime(timestamp)) != "Today") {
    return Text(getDateLabel(convertTimestampToDateTime(timestamp)),
        style: GoogleFonts.ptSerif(fontWeight: FontWeight.w400, fontSize: 12));
  } else {
    return Text(convertTimestampToString(timestamp)[1],
        style: GoogleFonts.ptSerif(fontWeight: FontWeight.w400, fontSize: 12));
  }
}

Future<CroppedFile?> openImagePicker(
    BuildContext context, ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(
      source: source, maxHeight: 400, maxWidth: 400, imageQuality: 30);
  if (image != null ) {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          IOSUiSettings(
              title: cropImage,
              aspectRatioPresets: [CropAspectRatioPreset.square]),
          AndroidUiSettings(
              toolbarTitle: cropImage,
              aspectRatioPresets: [CropAspectRatioPreset.square]),
          WebUiSettings(
            context: context,
          )
        ]);
    return croppedFile;
  }
  return null;
}
