import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../../../core/utils/controller_providers.dart';
import '../../../../injection_container.dart';
import '../../../widgets/buttons/text_buttons.dart';
import '../../../widgets/form_fields/apptextformfield.dart';
import '../../../widgets/text/app_text.dart';

class BaseUrlChangeView extends ConsumerWidget {
  const BaseUrlChangeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseTextController = ref.read(textController('baseurl'));
    baseTextController.text =
        ref.read(baseUrlProvider).replaceAll("http://", '');
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: AppText("Change Base Url"),
        trailingActions: [
          AppTextButton(
              onPressed: () {
                ref.read(baseUrlProvider.notifier).state =
                    'http://${baseTextController.text}';
                Get.toast("Base Url Changed");
                Get.pop();
              },
              text: "Save")
        ],
      ),
      body: Padding(
        padding: 20.allPad,
        child: Apptextformfield(
          autofocus: true,
          controller: baseTextController,
          hinttext: "Enter Base Url",
          textInputType: TextInputType.number,
          onSubmitted: (p0) {
            ref.read(baseUrlProvider.notifier).state =
                'http://${baseTextController.text}';
            Get.toast("Base Url Changed");
            Get.pop();
          },
        ),
      ),
    );
  }
}
