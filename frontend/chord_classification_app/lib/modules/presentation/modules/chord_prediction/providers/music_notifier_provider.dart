import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final musicFileProvider = StateProvider<File?>((_) => null);

final trimMusicFileProvider = StateProvider<File?>((_) => null);
