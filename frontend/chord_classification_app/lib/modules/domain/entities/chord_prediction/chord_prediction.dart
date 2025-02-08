class ChordPrediction {
  int start;
  int end;
  String chord;

  ChordPrediction(
      {required this.start, required this.end, required this.chord});

  ChordPrediction copyWith({
    int? start,
    int? end,
    String? chord,
    List<double>? amplitude,
  }) {
    return ChordPrediction(
        start: start ?? this.start,
        end: end ?? this.end,
        chord: chord ?? this.chord);
  }

  @override
  bool operator ==(covariant ChordPrediction other) {
    if (identical(this, other)) return true;

    return other.start == start && other.end == end && other.chord == chord;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ chord.hashCode;
}
