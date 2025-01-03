class ChordPrediction {
  int start;
  int end;
  String chord;
  List<double>? amplitude;

  ChordPrediction(
      {required this.start, required this.end, required this.chord,this.amplitude});

  ChordPrediction copyWith({
    int? start,
    int? end,
    String? chord,
    List<double>? amplitude,
  }) {
    return ChordPrediction(
      start:start ?? this.start,
      end:end ?? this.end,
      chord:chord ?? this.chord,
      amplitude:amplitude ?? this.amplitude,
    );
  }
}
