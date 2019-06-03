class SearchItem {
  final String id;
  final String departure;
  final String arrival;
  final int price;
  final DateTime date;

  SearchItem({this.id, this.departure, this.arrival, this.price, this.date});
}

class SearchInstance {
  static final SearchInstance _userInstance = new SearchInstance._internal();

  SearchItem user = SearchItem();
  List<String> origins = List();
  List<String> destinations = List();

  factory SearchInstance() {
    return _userInstance;
  }

  SearchInstance._internal();
}

final searchInstance = SearchInstance();
