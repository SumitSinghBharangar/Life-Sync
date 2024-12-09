import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:life_sync/common/buttons/scale_button.dart';
import 'package:life_sync/common/constants/app_collection.dart';
import 'package:life_sync/common/models/user_model.dart';
import 'package:life_sync/features/auth/screens/complete_profile.dart';
import 'package:life_sync/utils/utils.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
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
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
    _aboutController = TextEditingController();
    _emailController = TextEditingController();
    _dateController = TextEditingController();
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

  Future<void> _pickNUpload() async {
    var r = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (r != null) {
      imageUrl = null;
      pickedImage = File(r.path);
      imageUploading = true;
      setState(() {});

      var ref = FirebaseStorage.instance
          .ref(FirebaseAuth.instance.currentUser!.uid)
          .child('profilePicture');
      await ref.putFile(pickedImage!);
      String url = await ref.getDownloadURL();

      setState(() {
        imageUrl = url;
        imageUploading = false;
      });

      await FirebaseAuth.instance.currentUser?.updatePhotoURL(url);
    }
  }

  Future<void> _toggleEditMode() async {
    if (_isEditing) {
      UserModel updatedModel = UserModel(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        uid: uid,
        profileUrl: imageUrl ?? "",
        dob: _date!,
        updatedAt: DateTime.now(),
      );

      showLoading(context);
      await usersCollection.doc(uid).update(updatedModel.toMap());
      await FirebaseAuth.instance.currentUser!
          .updateDisplayName(_nameController.text);
      await FirebaseAuth.instance.currentUser!.reload();
      Navigator.pop(context);
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
      ),
      body: StreamBuilder(
        stream:
            usersCollection.where("uid", isEqualTo: uid).limit(1).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Utils.go(
                  context: context,
                  screen: const UserCompleteProfile(),
                  replace: true);
            });
            return const SizedBox();
          }

          var userData =
              snapshot.data!.docs.first.data() as Map<String, dynamic>;
          var model = UserModel.fromMap(userData);

          _nameController.text = model.name;
          _addressController.text = model.address;
          _phoneController.text = model.phone;
          _aboutController.text = model.address;
          _emailController.text = model.email;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                    model.profileUrl,
                                    loadingBuilder: (context, child, progress) {
                                      return progress == null
                                          ? child
                                          : const SpinKitWaveSpinner(
                                              waveColor: Colors.black,
                                              size: 80,
                                              color: Colors.black,
                                            );
                                    },
                                  ),
                                ),
                              if (pickedImage != null && imageUrl == null)
                                Positioned.fill(
                                    child: Image.file(pickedImage!)),
                              if (imageUrl != null)
                                Positioned.fill(
                                  child: Image.network(
                                    imageUrl!,
                                    loadingBuilder: (context, child, progress) {
                                      return progress == null
                                          ? child
                                          : const SpinKitWaveSpinner(
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
                                    filter: ImageFilter.blur(
                                        sigmaX: 10, sigmaY: 10),
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
          );
        },
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
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 8.h),
                  ),
                )
              : Text(
                  controller.text,
                  style: TextStyle(fontSize: 16.h, color: Colors.black),
                ),
        ],
      ),
    );
  }
}
