import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../core/configs/app_colors.dart';
import '../../../../../core/constants/chord_map.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../../domain/entities/chord_prediction/chord_prediction.dart';
import '../../../../injection_container.dart';

class GraphView extends ConsumerWidget {
  const GraphView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chordNotifier = ref.watch(chordPredictionNotifier);
    final rangeController = chordNotifier.rangeController;
    final predictions = chordNotifier.chordPredictions;
    return SfCartesianChart(
      key: Get.key(predictions),
      enableAxisAnimation: true,
      selectionType: SelectionType.point,
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Chords', textStyle: Get.bodySmall.px11),
        labelStyle: Get.bodySmall.px10,
      ),
      primaryYAxis: NumericAxis(
          rangeController: rangeController,
          minimum: 0,
          maximum: predictions.last.end.toDouble() + 8,
          rangePadding: ChartRangePadding.additionalStart,
          isVisible: true,
          labelStyle: Get.bodySmall.px10,
          title: AxisTitle(text: 'Duration', textStyle: Get.bodySmall.px11),
          enableAutoIntervalOnZooming: true),
      tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: false),
      isTransposed: true,
      margin: EdgeInsets.zero,
      enableSideBySideSeriesPlacement: true,
      onActualRangeChanged: (rangeChangedArgs) =>
          chordNotifier.panGraph(rangeChangedArgs.visibleMin.toString()),
      zoomPanBehavior: ZoomPanBehavior(
          enablePinching: false,
          enableSelectionZooming: true,
          enablePanning: true,
          zoomMode: ZoomMode.x,
          enableDoubleTapZooming: false),
      series: [
        RangeColumnSeries<ChordPrediction, String>(
          dataSource: predictions,
          xValueMapper: (ChordPrediction data, _) => data.chord,
          lowValueMapper: (datum, index) => datum.start,
          highValueMapper: (datum, index) => datum.end,
          onPointTap: (pointInteractionDetails) => chordNotifier
              .updateFromGraph(pointInteractionDetails.pointIndex ?? 0),
          enableTrackball: true,
          pointColorMapper: (datum, index) =>
              chordToColor[datum.chord] ?? AppColors.titleColor,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: Get.bodySmall.px10,
              margin: EdgeInsets.zero),
        ),
      ],
    );
  }
}
