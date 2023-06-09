class PageChangedData {
  final int from;
  final int to;

  const PageChangedData({required this.from, required this.to});

  @override
  String toString() {
    return 'PageView  from:$from  to:$to';
  }
}
