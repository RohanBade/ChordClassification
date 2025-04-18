import '../../../../domain/entities/chord_prediction/chord_prediction.dart';

List<String> _chordOrder = [
  "C",
  "C#",
  "D",
  "D#",
  "E",
  "F",
  "F#",
  "G",
  "G#",
  "A",
  "A#",
  "B",
  "Cm",
  "C#m",
  "Dm",
  "D#m",
  "Em",
  "Fm",
  "F#m",
  "Gm",
  "G#m",
  "Am",
  "A#m",
  "Bm"
];

extension PredictionX on List<ChordPrediction> {
  List<ChordPrediction> get sortChord => _shortChord(this);
}

List<ChordPrediction> _shortChord(List<ChordPrediction> predictions) {
  return List.from(predictions)
    ..sort((a, b) =>
        _chordOrder.indexOf(a.chord).compareTo(_chordOrder.indexOf(b.chord)));
}
