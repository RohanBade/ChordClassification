import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/configs/app_colors.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/services/get.dart';
import '../buttons/icon_buttons.dart';

class Apptextformfield extends StatelessWidget {
  const Apptextformfield(
      {super.key,
      this.tohide = false,
      this.controller,
      this.hinttext,
      this.textInputType,
      this.inputFormatters,
      this.icon,
      this.validator,
      this.onchanged,
      this.maxline = 1,
      this.suffixIcon,
      this.autofocus = false,
      this.readOnly = false,
      this.maxCharacter,
      this.title,
      this.fillColor,
      this.direction,
      this.suggestions,
      this.contentPadding,
      this.node,
      this.height,
      this.isDense = false,
      this.radius = 8,
      this.onSelected,
      this.onSubmitted});

  final bool tohide;
  final TextEditingController? controller;
  final String? hinttext;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? icon;
  final bool autofocus;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final int? maxline;
  final dynamic Function(String)? onchanged;
  final bool readOnly;
  final Widget? suffixIcon;
  final int? maxCharacter;
  final String? title;
  final Color? fillColor;
  final TextDirection? direction;
  final EdgeInsetsGeometry? contentPadding;
  final double radius;
  final double? height;
  final bool isDense;
  final FocusNode? node;
  final List<String>? suggestions;
  final dynamic Function(String)? onSubmitted;
  final dynamic Function(String)? onSelected;

  @override
  Widget build(BuildContext context) {
    final obscure = ValueNotifier<bool>(true);
    final border = OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(radius).rt);
    return ValueListenableBuilder(
      valueListenable: obscure,
      builder: (context, hide, child) {
        final bool obs = tohide && hide;
        return TextFormField(
            key: ValueKey(controller),
            readOnly: readOnly,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textDirection: direction ?? TextDirection.ltr,
            enableSuggestions: true,
            enableInteractiveSelection: true,
            magnifierConfiguration:
                TextMagnifier.adaptiveMagnifierConfiguration,
            undoController: UndoHistoryController(
                value: const UndoHistoryValue(canUndo: true, canRedo: true)),
            textAlign: TextAlign.justify,
            autofocus: autofocus,
            obscuringCharacter: '*',
            controller: controller,
            onFieldSubmitted: onSubmitted,
            obscureText: obs,
            spellCheckConfiguration: SpellCheckConfiguration(
                spellCheckService: DefaultSpellCheckService(),
                misspelledSelectionColor: AppColors.red),
            inputFormatters: inputFormatters,
            autocorrect: true,
            expands: maxline == null,
            showCursor: !readOnly,
            keyboardType: textInputType,
            validator: validator,
            onChanged: onchanged,
            maxLines: maxline,
            decoration: InputDecoration(
                isDense: isDense,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                contentPadding: contentPadding ?? 15.allPad,
                fillColor: fillColor,
                errorStyle: Get.bodySmall.error.px10,
                filled: true,
                labelStyle: Get.bodyMedium.px14,
                suffixIconColor: Get.disabledColor.o6,
                prefixIconColor: Get.disabledColor.o6,
                enabledBorder: border,
                errorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.red, width: 1),
                    borderRadius: BorderRadius.circular(radius).rt),
                focusedErrorBorder: border.copyWith(
                    borderSide: const BorderSide(color: AppColors.red)),
                focusedBorder: border,
                prefixIcon: icon != null
                    ? Padding(padding: 5.horizontalPad, child: icon)
                    : tohide
                        ? const AppIcon(Icons.lock)
                        : null,
                hintText: hinttext,
                alignLabelWithHint: true,
                hintStyle: Get.bodyMedium.px14.disabledO5,
                suffixIconConstraints: BoxConstraints(minHeight: 8.ht),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                suffixIcon: tohide
                    ? AppIcon(
                        onTap: () => obscure.value = !hide,
                        padding: 8.rightPad,
                        hide ? Icons.visibility_off : Icons.visibility_rounded)
                    : suggestions != null
                        ? AppIcon(Icons.arrow_drop_down,
                            color: Get.primaryColor, padding: 8.rightPad)
                        : suffixIcon));
      },
    );
  }
}
