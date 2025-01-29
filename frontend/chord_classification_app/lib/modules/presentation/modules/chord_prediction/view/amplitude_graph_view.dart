import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/extensions/list_extension.dart';
import '../../../../../core/services/get.dart';
import '../../../../injection_container.dart';

class AmplitudeGraphView extends ConsumerWidget {
  const AmplitudeGraphView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chordNotifier = ref.watch(chordPredictionNotifier);
    final amplitude = chordNotifier.amplitudesData;
    return SfCartesianChart(
      enableAxisAnimation: true,
      selectionType: SelectionType.point,
      primaryXAxis: NumericAxis(
        title: AxisTitle(text: 'Duration', textStyle: Get.bodySmall.px10),
        labelStyle: Get.bodySmall.px10,
        rangeController: chordNotifier.amplitudeController,
        maximum: chordNotifier.chordPredictions.last.end.toDouble() + 8,
      ),
      primaryYAxis: NumericAxis(
          rangePadding: ChartRangePadding.additionalStart,
          isVisible: true,
          maximum: (chordNotifier.amplitudes.max + 0.03),
          minimum: 0,
          labelStyle: Get.bodySmall.px10,
          title: AxisTitle(text: 'Amplitude', textStyle: Get.bodySmall.px10),
          enableAutoIntervalOnZooming: true),
      tooltipBehavior: TooltipBehavior(enable: false, canShowMarker: false),
      margin: EdgeInsets.zero,
      onActualRangeChanged: (rangeChangedArgs) =>
          chordNotifier.panGraph(rangeChangedArgs.visibleMin.toString()),
      enableSideBySideSeriesPlacement: true,
      zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enableSelectionZooming: true,
          enablePanning: true,
          zoomMode: ZoomMode.x,
          enableDoubleTapZooming: false),
      series: [
        SplineSeries<AmplitudeGraphData, num>(
          dataSource: amplitude,
          xValueMapper: (data, ind) => data.duration,
          yValueMapper: (datum, index) => datum.amplitude,
          color: chordNotifier.color,
          enableTrackball: true,
          dataLabelSettings: DataLabelSettings(margin: EdgeInsets.zero),
        ),
      ],
    );
  }
}

class AmplitudeGraphData {
  final double amplitude;
  final double duration;

  AmplitudeGraphData({required this.amplitude, required this.duration});
}
