import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:life_sync/common/app_colors.dart';
import 'package:life_sync/common/buttons/scale_button.dart';
import 'package:life_sync/common/constants/app_collection.dart';
import 'package:life_sync/common/models/user_model.dart';
import 'package:life_sync/features/auth/screens/complete_profile.dart';
import 'package:life_sync/utils/utils.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    super.key,
  });

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserModel? model;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  _init() async {
    var r = await usersCollection.where("uid", isEqualTo: uid).limit(1).get();
    if (r.docs.isEmpty) {
      Utils.go(
          context: context, screen: const UserCompleteProfile(), replace: true);
    } else {
      setState(() {
        model = UserModel.fromMap(r.docs.first.data());
      });
    }
  }

  String phturl = FirebaseAuth.instance.currentUser!.photoURL.toString();
  var currentuser = FirebaseAuth.instance.currentUser;
  bool _isEditing = false;
  String? imageUrl;
  File? pickedImage;
  DateTime? _date;
  bool imageUploading = false;

  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _aboutController;
  late TextEditingController _emailController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });

    _nameController = TextEditingController(text: model?.name ?? "");
    _addressController = TextEditingController(text: model?.address ?? "");
    _phoneController = TextEditingController(text: model?.phone ?? "");
    _aboutController = TextEditingController(text: model?.address ?? "");
    _emailController = TextEditingController(text: model?.email ?? "");
    _dateController = TextEditingController(text: model?.email ?? "");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _aboutController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now(); // Current date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now, // Set initial date to current date
      firstDate: now, // Restrict selection to dates from today onwards
      lastDate: DateTime(2101), // Latest date selectable
    );

    if (pickedDate != null) {
      // Format and set the date into the text field
      setState(() {
        _dateController.text = DateFormat('d MMMM yyyy').format(pickedDate);
        _date = pickedDate;
      });
    }
  }

  Future<void> _toggleEditMode() async {
    UserModel model = UserModel(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      uid: uid,
      profileUrl: imageUrl!,
      dob: _date!,
      updatedAt: DateTime.now(),
      
    );
    if (_isEditing) {
      showLoading(context);
      await usersCollection.doc(uid).update(model.toMap());
      await currentuser!.updateDisplayName(_nameController.text);
      await currentuser!.updatePhotoURL(phturl);
      await currentuser!.reload();
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.save : Icons.edit,
              color: Colors.black,
            ),
            onPressed: _toggleEditMode,
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 30.h,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Profile Photo
              Center(
                child: ScaleButton(
                  onTap: _pickNUpload,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(250),
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.2),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        children: [
                          if (imageUrl == null && pickedImage == null)
                            Center(
                              child: Image.network(
                                FirebaseAuth.instance.currentUser!.photoURL
                                    .toString(),
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress?.cumulativeBytesLoaded ==
                                      null) {
                                    return child;
                                  }
                                  return const SpinKitWaveSpinner(
                                    waveColor: Colors.black,
                                    size: 80,
                                    color: Colors.black,
                                  );
                                },
                              ),
                            ),
                          if (pickedImage != null && imageUrl == null)
                            Positioned.fill(child: Image.file(pickedImage!)),
                          if (imageUrl != null)
                            Positioned.fill(
                              child: Image.network(
                                imageUrl!,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress?.cumulativeBytesLoaded ==
                                      null) {
                                    return child;
                                  }
                                  return const SpinKitWaveSpinner(
                                    waveColor: Colors.black,
                                    size: 80,
                                    color: Colors.black,
                                  );
                                },
                              ),
                            ),
                          if (imageUploading)
                            Positioned.fill(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: const SizedBox.expand(),
                              ),
                            ),
                          if (imageUploading)
                            Container(
                              color: Colors.white.withOpacity(.3),
                            ),
                          if (imageUploading)
                            const Align(
                              alignment: Alignment.center,
                              child: SpinKitWaveSpinner(
                                waveColor: Colors.white,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Profile Fields
              _buildProfileField(
                  label: 'Name',
                  controller: _nameController,
                  isEditing: _isEditing),
              _buildProfileField(
                  label: 'Email',
                  controller: _emailController,
                  isEditing: _isEditing),
              _buildProfileField(
                  label: 'Phone Number',
                  controller: _phoneController,
                  isEditing: _isEditing),
              _buildProfileField(
                  label: 'Address',
                  controller: _addressController,
                  isEditing: _isEditing),
              _buildProfileField(
                  label: 'About',
                  controller: _aboutController,
                  isEditing: _isEditing,
                  maxLines: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.h,
                color: Colors.black),
          ),
          SizedBox(height: 5.h),
          isEditing
              ? TextField(
                  controller: controller,
                  maxLines: maxLines,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 8.h),
                  ),
                )
              : Text(
                  controller.text,
                  style: TextStyle(
                    fontSize: 16.h,
                    color: Colors.black,
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> _pickNUpload() async {
    var r = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (r != null) {
      imageUrl = null;
      pickedImage = File(r.path);
      imageUploading = true;
      setState(() {
        var u = FirebaseAuth.instance.currentUser?.uid;
        var ref = FirebaseStorage.instance.ref(u);
        ref = ref.child('profilePicture');
        ref.putData(pickedImage!.readAsBytesSync()).whenComplete(() async {
          String url = await ref.getDownloadURL();
          imageUrl = url;
          await FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
          await FirebaseAuth.instance.currentUser?.reload();
          imageUploading = false;
          setState(() {});
        });
      });
      // var c = await ImageCropper().cropImage(
      //     sourcePath: r.path,
      //     aspectRatio: const CropAspectRatio(ratioX: 2, ratioY: 2));
      // if (c != null) {
      //   imageUrl = null;
      //   pickedImage = File(c.path);
      //   imageUploading = true;
      //   setState(() {});

      // }
    }
  }
}
