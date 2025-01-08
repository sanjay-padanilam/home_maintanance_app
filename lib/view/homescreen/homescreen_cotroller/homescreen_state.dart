class HomescreenState {
  String? name;
  HomescreenState({this.name});

  HomescreenState copyWith({String? name}) {
    return HomescreenState(name: name ?? this.name);
  }
}
