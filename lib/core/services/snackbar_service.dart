
import 'package:injectable/injectable.dart';

@lazySingleton
class SnackbarService {
  late Function(String) _showErrorSnackbar;
  late Function(String) _showSuccessSnackbar;

  void registerSnackbarsListeners(Function(String) error, Function(String) success) {
    _showErrorSnackbar = error;
    _showSuccessSnackbar = success;
  }

  void showErrorSnackbar(String text) => _showErrorSnackbar(text);
  void showSuccessSnackbar(String text) => _showSuccessSnackbar(text);
}
