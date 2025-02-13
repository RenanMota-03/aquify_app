abstract class AnalyticsState {}

class AnalyticsStateInitial extends AnalyticsState {}

class AnalyticsStateLoading extends AnalyticsState {}

class AnalyticsStateSuccess extends AnalyticsState {}

class AnalyticsStateError extends AnalyticsState {
  final String message;

  AnalyticsStateError(this.message);
}
