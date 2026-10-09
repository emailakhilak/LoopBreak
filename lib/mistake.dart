class Mistake {
  String title;
  String trigger;
  String consequence;
  String solution;
  String category;
  final DateTime createdAt;
  int occurrenceCount;
  bool isResolved;

  Mistake({
    required this.title,
    required this.trigger,
    required this.consequence,
    required this.solution,
    required this.category,
    required this.createdAt,
    this.occurrenceCount = 1,
    this.isResolved = false,
  });
}
