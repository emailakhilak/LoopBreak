class Mistake {
  final String title;
  final String trigger;
  final String consequence;
  final String solution;
  final String category;
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
