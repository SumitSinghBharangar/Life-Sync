import 'dart:io';

import 'package:bounce/bounce.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_sync/common/buttons/bold_button.dart';
import 'package:life_sync/common/buttons/round_bold_button.dart';
import 'package:life_sync/common/buttons/scale_button.dart';
import 'package:life_sync/common/models/user_model.dart';
import 'package:life_sync/screens/home/home_screen.dart';
import 'package:life_sync/screens/onboarding/onbording_screen.dart';
import 'package:life_sync/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? profile;

  final _fKey = GlobalKey<FormState>();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _name = TextEditingController(
    text: FirebaseAuth.instance.currentUser?.displayName,
  );

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Form(
          key: _fKey,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.paddingOf(context).top + 20.h),
              Row(
                children: [
                  Text(
                    "Complete your\nProfile",
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      await _auth.signOut();
                      if (context.mounted) {
                        Utils.go(
                            context: context,
                            screen: const OnbordingScreen(),
                            replace: true);
                      }
                    },
                    icon: const Icon(Iconsax.logout_1),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Center(
                child: ScaleButton(
                  onTap: () async {
                    var c = await imageToVar(1, 1);
                    if (c == null) return;
                    setState(() {
                      profile = File(c.path);
                    });
                  },
                  child: profile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: Image.file(
                            profile!,
                            height: 160.h,
                            width: 160.h,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          height: 160.h,
                          width: 160.h,
                          padding: EdgeInsets.all(54.h),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                          ),
                          child: const FittedBox(
                            child: Icon(
                              IconlyLight.profile,
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(height: 30.h),
              TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your name";
                  }
                  if (value.length < 3) {
                    return "Must have at least 3 chars";
                  }
                  return null;
                },
                controller: _name,
                decoration: InputDecoration(
                  hintText: "Full Name",
                  prefixIcon: const Icon(Iconsax.user_octagon),
                  contentPadding: EdgeInsets.all(16.h),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.h),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your Phone no";
                  }
                  if (value.length != 10) {
                    return "Must have 10 chars";
                  }
                  return null;
                },
                controller: _phone,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: "Phone",
                  prefixIcon: const Icon(Iconsax.call),
                  contentPadding: EdgeInsets.all(16.h),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.h),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your address";
                  }
                  if (value.length < 3) {
                    return "Must have at least 3 chars";
                  }
                  return null;
                },
                controller: _address,
                decoration: InputDecoration(
                  hintText: "Address",
                  prefixIcon: const Icon(Iconsax.building_4),
                  contentPadding: EdgeInsets.all(16.h),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.h),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * .15),
              FractionallySizedBox(
                widthFactor: 1,
                child: RoundBoldButton(
                  onPressed: () {},
                  child: Text(
                    "Continue",
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Wrap(
                children: [
                  const FittedBox(
                    child: Text(
                        "By proceeding you consent to get calls, WhatsApp or\nSMS, including by automated dialer and you accept the "),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "terms of service",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(" and "),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "privacy policy.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> imageToVar(double ratioX, double ratioY) async {
    var f = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (f == null) return null;
    var c = await ImageCropper().cropImage(
      sourcePath: f.path,
      aspectRatio: CropAspectRatio(ratioX: ratioX, ratioY: ratioY),
    );
    return c == null ? null : File(c.path);
  }
}


// if (_fKey.currentState?.validate() ?? false) {
//                         if (profile == null) {
//                           Fluttertoast.showToast(
//                               msg: "Please select a profile picture");
//                           return;
//                         }
//                         var user = FirebaseAuth.instance.currentUser!;
//                         var imageUrl = await fileToFirebase(
//                           path: ["users", user.uid],
//                           name: "profile",
//                           file: profile!,
//                         );
//                         String? token =
//                             await FirebaseMessaging.instance.getToken();
//                         UserModel model = UserModel(
//                           mail: user.email!,
//                           homeAddress: _address.text.trim(),
//                           image: imageUrl,
//                           imageUrl: imageUrl,
//                           name: _name.text.trim(),
//                           phone: _phone.text.trim(),
//                           tokens: [token!],
//                           uid: user.uid,
//                         );
//                         if (context.mounted) {
//                           await updateProfile(model);
//                           // here we made the bloc for uploading the profile information by made the function of updating the profile
//                           // then make the navigation to the main screen by binding it in the bloc listner
//                         }