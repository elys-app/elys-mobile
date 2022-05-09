import 'package:elys_mobile/models/ModelProvider.dart';
import 'package:image_picker/image_picker.dart';

class PendingPageArguments {
  final SpecialEvent event;
  final XFile content;

  PendingPageArguments(this.event, this.content);
}
