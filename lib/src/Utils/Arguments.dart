class SingleMovieArguments {
  String image = "";
  String name = "";
  String description = "";
  String type = "";
  double rating = 0;
  String statusBar = "";
  List<Map<String, dynamic>> screenshoots = [];

  SingleMovieArguments(Map data) {
    this.image = data['image'];
    this.name = data['name'];
    this.description = data['description'];
    this.type = data['type'];
    this.rating = data['rating'];
    this.screenshoots = data['screenshoots'];
    this.statusBar = data['statusBar'];
  }
}
