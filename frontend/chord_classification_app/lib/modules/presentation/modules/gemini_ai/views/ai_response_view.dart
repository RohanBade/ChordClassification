// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:typewritertext/typewritertext.dart';

// import '../../../../../core/extensions/extensions.dart';
// import '../../../../../core/services/get.dart';
// import '../../../../injection_container.dart';
// import '../providers/async_providers.dart';

// class AiResponseView extends ConsumerWidget {
//   const AiResponseView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final airesponse = ref.watch(getAiResponseProvider);
//     return airesponse.when(
//         skipLoadingOnRefresh: false,
//         error: (error, stackTrace) => SizedBox.shrink(),
//         loading: () => SizedBox.shrink(),
//         data: (_) {
//           final response = ref.watch(aiNotifierProvider).message;
//           return TypeWriter.text(response,
//               duration: 1.milliSeconds, style: Get.bodyMedium.px14);
//         });
//   }
// }
