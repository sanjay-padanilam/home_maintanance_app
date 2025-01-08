class HomescreenState {
  String? name;
  bool isLoading;

  HomescreenState({this.name, this.isLoading = false});

  HomescreenState copyWith({String? name, bool? isLoading}) {
    return HomescreenState(
        name: name ?? this.name, isLoading: isLoading ?? this.isLoading);
  }
}
