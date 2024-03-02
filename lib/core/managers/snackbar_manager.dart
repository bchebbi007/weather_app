
import 'package:flutter/material.dart';
import 'package:flutter_snackbar_plus/flutter_snackbar_plus.dart';


import '../../injection.dart';
import '../services/snackbar_service.dart';

///Snackbar manager class
///
///Used to eliminate displaying snackbar without context in the entire app
class SnackbarManager extends StatefulWidget {
  SnackbarManager({required this.child});

  ///The child to be passed to the snackbar manager
  final Widget child;

  @override
  _SnackbarManagerState createState() => _SnackbarManagerState();
}

class _SnackbarManagerState extends State<SnackbarManager> {
  final SnackbarService _snackbarService = locator<SnackbarService>();

  ///The error and success flushbar
  // late Flushbar _errorSnackBar, _successSnackBar;

  ///The duration until Flushbar will be dismissed automatically
  final Duration _snackbarDuration = Duration(seconds: 3);

  ///Register the list of snackbar listners
  @override
  void initState() {
    super.initState();
    _snackbarService.registerSnackbarsListeners(
        showErrorSnackBar, showSuccessSnackBar);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  ///Display error snackbar containing [mainText]
  showErrorSnackBar(String mainText) {
    FlutterSnackBar.showTemplated(
      context,
      title: 'Erreur',
      message: mainText,
      leading: Icon(
        Icons.info,
        size: 32,
        color: Colors.red,
      ),
      //trailing: const Text('trailing!'),
      style: FlutterSnackBarStyle(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        radius: BorderRadius.circular(6),
        backgroundColor: Colors.white,
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.55),
          blurRadius: 32,
          offset: const Offset(0, 12),
          blurStyle: BlurStyle.normal,
          spreadRadius: -10,
        ),
        leadingSpace: 22,
        trailingSpace: 12,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        titleStyle: const TextStyle(fontSize: 20, color: Colors.red),
        messageStyle:
        TextStyle(fontSize: 16, color: Colors.black),
        titleAlignment: TextAlign.start,
        messageAlignment: TextAlign.start,
        loadingBarColor: Colors.red,
        // loadingBarRailColor: Colors.yellow.withOpacity(0.4),
      ),
      configuration: const FlutterSnackBarConfiguration(
        location: FlutterSnackBarLocation.bottom,
        distance: 35,
        animationCurve: Curves.ease,
        animationDuration: Duration(milliseconds: 500),
        showDuration: Duration(seconds: 2),
        // persistent: true,
        dismissible: true,
        dismissDirection: DismissDirection.down,
      ),
    );

  }

  ///Display success snackbar containing [mainText]
  showSuccessSnackBar(String mainText) {
    FlutterSnackBar.showTemplated(
      context,
      title: 'Information',
      message: mainText,
      leading: Icon(
        Icons.info,
        size: 32,
        color: Colors.green,
      ),
      //trailing: const Text('trailing!'),
      style: FlutterSnackBarStyle(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        radius: BorderRadius.circular(6),
        backgroundColor: Colors.white,
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.55),
          blurRadius: 32,
          offset: const Offset(0, 12),
          blurStyle: BlurStyle.normal,
          spreadRadius: -10,
        ),
        leadingSpace: 22,
        trailingSpace: 12,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        titleStyle: TextStyle(
            fontSize: 20, color:Colors.green),
        messageStyle:
        TextStyle(fontSize: 16, color: Colors.black),
        titleAlignment: TextAlign.start,
        messageAlignment: TextAlign.start,
        loadingBarColor: Colors.green,
        // loadingBarRailColor: Colors.yellow.withOpacity(0.4),
      ),
      configuration: const FlutterSnackBarConfiguration(
        location: FlutterSnackBarLocation.bottom,
        distance: 35,
        animationCurve: Curves.ease,
        animationDuration: Duration(milliseconds: 500),
        showDuration: Duration(seconds: 2),
        // persistent: true,
        dismissible: true,
        dismissDirection: DismissDirection.down,
      ),
    );

  }
}
