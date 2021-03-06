import 'package:gutenberg_project/Services/networking.dart';

const bookAPIUrl = 'http://skunkworks.ignitesol.com:8000/books/?mime_type=image%2Fjpeg';

class CatalogService {
  Future<dynamic> getBooks(String category) async {
    var url = '$bookAPIUrl&topic=$category';
    NetworkHelper networkHelper = NetworkHelper(url);
    var catalogData = await networkHelper.getData();
    return catalogData;
  }

  Future<dynamic> searchBooks(String category, String searchQuery) async {
    List<String> list = searchQuery.split(' ');
    searchQuery = list.join('%20');
    var url = '$bookAPIUrl&topic=$category&search=$searchQuery';
    NetworkHelper networkHelper = NetworkHelper(url);
    var catalogData = await networkHelper.getData();
    return catalogData;
  }
}