import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final musicFileProvider = StateProvider<File?>((_) => null);

final savedMusicFileProvider=StateProvider<File?>((_) => null);