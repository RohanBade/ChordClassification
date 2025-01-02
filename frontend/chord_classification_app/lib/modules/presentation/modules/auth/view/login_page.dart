import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../../../core/services/validators/form_validators.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/controller_providers.dart';
import '../../../../../core/utils/key_providers.dart';
import '../../../../injection_container.dart';
import '../../../widgets/buttons/app_buttons.dart';
import '../../../widgets/buttons/icon_buttons.dart';
import '../../../widgets/form_fields/apptextformfield.dart';
import '../../../widgets/text/app_name.dart';
import '../../../widgets/text/app_text.dart';
import '../../../widgets/text/myrichtext.dart';
import '../../homepage/views/homepage.dart';
import 'signup_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.read(noDiposeTextControllers('email'));
    final password = ref.read(textController('password'));
    final formKey = ref.read(formkey("Login"));
    final authRepo = ref.read(authRepoProvider);
    return PlatformScaffold(
      body: Form(
        key: formKey,
        child: ListView(padding: 20.allPad, children: [
          50.verticalGap,
          const AppName(fontsize: 35),
          40.verticalGap,
          AppText("Login", style: Get.bodyLarge.px24),
          20.verticalGap,
          Apptextformfield(
              hinttext: "Email",
              icon: const AppIcon(AppIcons.email),
              autofocus: true,
              validator: emailValidator.call,
              controller: email),
          10.verticalGap,
          Apptextformfield(
              hinttext: 'Password',
              tohide: true,
              controller: password,
              validator: passwordValidator.call),
          20.verticalGap,
          AppButton(
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  if (await authRepo.login(email.text, password.text)) {
                    Get.offAll(const Homepage());
                  }
                }
              },
              text: 'Login'),
          10.verticalGap,
          Center(
              child: Myrich(
            prefix: "Not Registered?",
            suffix: "Register now",
            onTap: () => Get.to(const SignUpPage()),
          )),
        ]),
      ),
    );
  }
}
