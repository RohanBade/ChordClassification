extension DoubleList on List<double> {
  double get max =>
      reduce((value, element) => value > element ? value : element);
}
