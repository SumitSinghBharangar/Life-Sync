import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:life_sync/common/buttons/dynamic_button.dart';
import 'package:life_sync/common/buttons/scale_button.dart';
import 'package:life_sync/common/constants/app_collection.dart';
import 'package:life_sync/common/models/user_model.dart';
import 'package:life_sync/features/auth/sevices/auth_service.dart';
import 'package:life_sync/features/home/smart_home_screen.dart';
import 'package:life_sync/features/onbording_screens/on_bording_screen.dart';
import 'package:life_sync/utils/utils.dart';
import 'package:provider/provider.dart';

class UserCompleteProfile extends StatefulWidget {
  const UserCompleteProfile({super.key});

  @override
  State<UserCompleteProfile> createState() => _UserCompleteProfileState();
}

class _UserCompleteProfileState extends State<UserCompleteProfile> {
  File? profile;

  final _fKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _dob = TextEditingController();

  _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = context.watch<AuthServices>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _fKey,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.paddingOf(context).top + 20),
              Row(
                children: [
                  const Text(
                    "Complete your\nProfile",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();

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
              const SizedBox(height: 24),
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
                          padding: const EdgeInsets.all(54),
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
              const SizedBox(height: 24),
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
                  contentPadding: const EdgeInsets.all(16),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your email";
                  }
                  String pattern =
                      r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
                  RegExp regex = RegExp(pattern);
                  if (!regex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                controller: _email,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  contentPadding: const EdgeInsets.all(16),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your address";
                  }

                  return null;
                },
                controller: _address,
                decoration: InputDecoration(
                  hintText: "Address",
                  prefixIcon: const Icon(Iconsax.building_4),
                  contentPadding: const EdgeInsets.all(16),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your date of birth!";
                  }
                  if (value.length < 3) {
                    return "Must have at least 3 chars";
                  }
                  return null;
                },
                controller: _dob,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Date of Birth",
                  prefixIcon: const Icon(Iconsax.calendar),
                  contentPadding: const EdgeInsets.all(16),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onTap: () => _selectDate(
                  context,
                  _dob,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * .15),
              FractionallySizedBox(
                widthFactor: 1,
                child: DynamicButton.fromText(
                  text: "Continue",
                  onPressed: () async {
                    if (_fKey.currentState?.validate() ?? false) {
                      if (profile == null) {
                        Fluttertoast.showToast(
                            msg: "Please select a profile picture");
                        return;
                      }
                      showLoading(context);

                      var user = FirebaseAuth.instance.currentUser!;
                      var imageUrl = await w.fileToFirebase(
                        path: [
                          'users',
                          user.uid,
                        ],
                        name: 'profile',
                        file: profile!,
                      );
                      String? token =
                          await FirebaseMessaging.instance.getToken();

                      UserModel model = UserModel(
                        email: _email.text,
                        uid: user.uid,
                        name: _name.text,
                        profile: imageUrl,
                        phone: FirebaseAuth.instance.currentUser!.phoneNumber ??
                            "",
                        address: _address.text,
                        profileUrl: imageUrl,
                        tokens: [token!],
                        dob: DateTime.parse(_dob.text),
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );
                      await user.updateDisplayName(_name.text);
                      await user.updatePhotoURL(imageUrl);

                      await usersCollection
                          .doc(user.uid)
                          .update((model).toMap());

                      if (context.mounted) {
                        Navigator.pop(context);
                        Utils.go(
                            context: context,
                            screen: const SmartHomeScreen(),
                            replace: true);

                        // go to home page
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                children: [
                  const FittedBox(
                    child: Text(
                      "By proceeding you consent to get calls, WhatsApp or\nSMS, including by automated dialer and you accept the ",
                    ),
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
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> imageToVar(double ratioX, double ratioY) async {
    var f = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (f == null) return null;
    return File(f.path);
    // var c = await ImageCropper().cropImage(
    //   sourcePath: f.path,
    //   aspectRatio: CropAspectRatio(ratioX: ratioX, ratioY: ratioY),
    // );
    // return c == null ? null : File(c.path);
  }
}
