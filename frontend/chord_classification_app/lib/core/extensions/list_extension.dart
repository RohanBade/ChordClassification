extension DoubleList on List<double> {
  double get max =>
      reduce((value, element) => value > element ? value : element);
}

extension IntList on List<int>{
  List<double> get normalize=>normalizeAmplitudes(this);
}

List<double> normalizeAmplitudes(List<int> amplitudes) {
  if (amplitudes.isEmpty) return [];

  int minAmp = amplitudes.reduce((a, b) => a < b ? a : b);
  int maxAmp = amplitudes.reduce((a, b) => a > b ? a : b);

  if (maxAmp == minAmp) {
    return List.filled(amplitudes.length, 0.0);
  }

  return amplitudes.map((a) => (a - minAmp) / (maxAmp - minAmp)).toList();
}