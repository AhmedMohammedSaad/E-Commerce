class StringesForApi {
  final String baseUrl = 'https://uvedejatxeoieqysxkbc.supabase.co/rest/v1/';
  final String apiKey = 'apikey';
}

class Endpoint {
  static String getComment(id) =>
      "products?product_id=eq.$id&select=product_id,comments(*,users(name))";
  static String getAdvertisements = "advertisements";
  static String getProduct = "products?select=*,favorte(*),rating(*)";
}
