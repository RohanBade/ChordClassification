import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'string_extensions.dart';

extension FileX on File {
  String get fileName => path.basename(this.path).lastwords;
}