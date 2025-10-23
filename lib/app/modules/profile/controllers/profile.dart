import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hatud/app/modules/home/controllers/home.dart';
import '../../../service/user_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends GetxController {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final mnameController = TextEditingController();
  final mapLocController = TextEditingController();
  // final emailController = TextEditingController();
  final contactnoController = TextEditingController();
  // final passwordController = TextEditingController();
  final addressController = TextEditingController();
  double lat = 0, long = 0;
  final ImagePicker _picker = ImagePicker();
  final Rx<File?> imageFile = Rx<File?>(null);
  final Rx<String?> profileImagePath = Rx<String?>(null);
  // mage.network(
  //                                   '$thumbRoute${item.thumb}',
  //                                   width: 100,
  //                                   height: 100,
  //                                   fit: BoxFit.cover,
  //                                 ),
  // final storage = const FlutterSecureStorage();

  @override
  void onInit() {
    final home = Get.find<Home>();
    ever(home.user, (user) {
      if (user != null) {
        init(home);
      }
    });
    super.onInit();
  }

  Future<void> checkLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isGranted) {
      debugPrint('Location permission granted');
    } else if (status.isDenied) {
      // Request permission
      var result = await Permission.location.request();
      if (result.isGranted) {
        debugPrint('Location permission granted after request');
      } else {
        debugPrint('Location permission denied');
      }
    } else if (status.isPermanentlyDenied) {
      // Open app settings
      debugPrint('Permission permanently denied. Opening settings...');
      await openAppSettings();
    }
  }

  Future<bool> checkMediaPermission() async {
    var status = await Permission.storage.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      // Request permission
      var result = await Permission.storage.request();
      if (result.isGranted) {
        return true;
      } else {
        return false;
      }
    } else if (status.isPermanentlyDenied) {
      return await openAppSettings();
    }
    return false;
  }

  void init(Home home) async {
    await checkLocationPermission();

    fnameController.text = home.user.value!.fname;
    lnameController.text = home.user.value!.lname;
    mnameController.text = home.user.value!.mname!;
    // emailController.text = home.user.value!.email;
    addressController.text = home.user.value!.address;
    contactnoController.text = home.user.value!.contactno;
    profileImagePath.value = home.user.value!.photo;

    lat = home.user.value!.lat;
    long = home.user.value!.long;
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        lat,
        long,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        mapLocController.text =
            "${p.street ?? ''}, ${p.subLocality ?? ''}, ${p.locality ?? ''}, ${p.administrativeArea ?? ''}, ${p.country ?? ''}"
                .replaceAll(RegExp(r', ,'), ',');
      }
    } catch (e) {
      debugPrint('Reverse geocoding failed: $e');
    }
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    fnameController.dispose();
    mnameController.dispose();
    lnameController.dispose();
    addressController.dispose();
    contactnoController.dispose();
    mapLocController.dispose();
    super.onClose();
  }

  void openMedia() async {
    // bool canAccess = await checkMediaPermission();

    // if (!canAccess) {
    //   Get.snackbar(
    //     'Cant Access Photos',
    //     'Please allow permission in photos',
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //     snackPosition: SnackPosition.TOP,
    //   );
    // }

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      debugPrint('Picked image path: ${image.path}');
      imageFile.value = File(image.path);
    } else {
      debugPrint('No image selected.');
    }
  }

  void updateUser() async {
    final userData = {
      'fname': fnameController.text,
      'lname': lnameController.text,
      'mname': mnameController.text,
      'contactno': contactnoController.text,
      'lat': lat,
      'long': long,
      'address': addressController.text, // from reverse geocode
    };
    final home = Get.find<Home>();
    final token = home.token;
    if (token == null) {
      debugPrint('No auth token available, aborting update');
      return;
    }
    await UserService.updateUser(token, userData, imageFile: imageFile.value);
  }
}
