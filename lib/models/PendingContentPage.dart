import 'dart:io';

import 'package:elys_mobile/models/ModelProvider.dart';

class PendingContentPageArguments {
  final Content item;
  final File content;

  PendingContentPageArguments(this.item, this.content);
}
