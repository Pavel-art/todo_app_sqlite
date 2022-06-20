
part of "todo_cubit.dart";


@immutable
abstract class TodoState extends Equatable {}

class EmptyState extends TodoState {
  @override
  List<Object?> get props => [];
  
}

class LoadingState extends TodoState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends TodoState {
  final List<dynamic> todolist;

  LoadedState({required this.todolist});

  @override 
  List<Object?> get props => [todolist];
}

class ErrorState extends TodoState {
  @override
  List<Object?> get props =>[];
  
}
