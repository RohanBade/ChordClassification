import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../../../core/services/validators/form_validators.dart';
import '../../../../../core/utils/key_providers.dart';
import '../../../widgets/form_fields/apptextformfield.dart';

class NameAlertDialog extends ConsumerWidget {
  const NameAlertDialog(
      {super.key, required this.title, required this.content});

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = ref.watch(formkey("fileName"));
    return Form(
      key: formKey,
      child:
          PlatformAlertDialog(title: Text(title), content: content, actions: [
        PlatformDialogAction(
          child: Text("Confirm"),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              Get.pop();
            }
          },
          cupertino: (context, platform) =>
              CupertinoDialogActionData(isDestructiveAction: false),
        )
      ]),
    );
  }
}

showSetNameDialog(TextEditingController controller) async {
  controller.text = DateTime.now().millisecond.toString();
  await showPlatformDialog(
      context: Get.context,
      builder: (context) => NameAlertDialog(
          title: "Enter File Name",
          content: Padding(
              padding: 10.verticalPad,
              child: Consumer(
                builder: (context, ref, child) {
                  return Apptextformfield(
                      controller: controller,
                      validator: requiredValidator("name").call,
                      autofocus: true,
                      hinttext: "Enter File Name");
                },
              ))));
}
