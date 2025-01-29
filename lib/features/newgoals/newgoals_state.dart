abstract class NewGoalsState {}

class NewGoalsStateInitial extends NewGoalsState {}

class NewGoalsStateLoading extends NewGoalsState {}

class NewGoalsStateSuccess extends NewGoalsState {}

class NewGoalsStateError extends NewGoalsState {
  final String message;
  NewGoalsStateError(this.message);
}
