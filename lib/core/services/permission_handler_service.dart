import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../errors/failure/failures.dart';


@LazySingleton()
class PermissonHandlerService {


  final PermissionStatus _permissionStatus = PermissionStatus.denied;

  PermissonHandlerService();



  Future<Map<Permission, PermissionStatus>> requestPermission() async {
    try {
      final status =  await [
        Permission.location,
      ].request();
      debugPrint('status :$status');
      debugPrint('_permissionStatus : $status');
      return status;
    }on Exception catch (e) {
      throw PermissionCheckFailure(
          PermissionCheckFailureType.unknown, e.toString());
    }
  }

}