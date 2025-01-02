// import 'package:flutter/cupertino.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';

// import '../../../../domain/entities/chord_prediction/chord_prediction.dart';

// class AiNotifier extends ChangeNotifier {
//   final String _requestMessage = """
//       Summarize this result in bullets in  Markdown format. I have provided
//        """;

//   bool isAnalyzing = false;
//   late Gemini gemini;

//   String message = '';

//   AiNotifier() {
//     try {
//       Gemini.init(apiKey: dotenv.get('GEMINIKEY'));
//       gemini = Gemini.instance;
//     } catch (e) {
//       print("hello $e");
//     }
//   }

//   Future getResponse(List<ChordPrediction> predictions) async {
//     Candidates? aiResponse;
//     isAnalyzing = true;
//     final predictionsMessage = predictions.map((e) => e.toString()).join(',');
//     notifyListeners();
//     try {
//       aiResponse = await gemini
//           .prompt(parts: [Part.text('$predictionsMessage $_requestMessage')]);
//       message = aiResponse?.output ?? '';
//       isAnalyzing = false;
//       notifyListeners();
//     } catch (e) {
//       isAnalyzing = false;
//       notifyListeners();
//     }
//   }
// }
