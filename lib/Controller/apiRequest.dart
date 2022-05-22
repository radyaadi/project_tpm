import 'package:project_tpm/Controller/baseNetwork.dart';

class CocktailDataSource {
  static CocktailDataSource instance = CocktailDataSource();
  Future<Map<String, dynamic>> loadCocktail() {
    return BaseNetwork.get("search.php?s");
  }
}