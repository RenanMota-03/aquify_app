import '../../common/models/analytics_model.dart';

abstract class AnalyticsState {}

class AnalyticsStateInitial extends AnalyticsState {}

class AnalyticsStateLoading extends AnalyticsState {}

class AnalyticsStateSuccess extends AnalyticsState {
  final List<AnalyticsModel> analyticsData;

  AnalyticsStateSuccess(this.analyticsData);
}

class AnalyticsStateError extends AnalyticsState {
  final String message;

  AnalyticsStateError(this.message);
}
