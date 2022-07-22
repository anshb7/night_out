import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void selecfile() async {
  final result = await FilePicker.platform.pickFiles(allowMultiple: false);
  if (result == null) {
    return null;
  }
  final path = result.files.single.path;
}
