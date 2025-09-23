class ApiConfig {
  // Replace with your actual Gemini API key
  // Get your API key from: https://makersuite.google.com/app/apikey
  static const String geminiApiKey = 'AIzaSyCRNV5pfFOWRoazEffyCRuiOtjSiju9_yU';

  // Check if API key is configured
  static bool get isApiKeyConfigured =>
      geminiApiKey != 'AIzaSyCRNV5pfFOWRoazEffyCRuiOtjSiju9_yU' &&
      geminiApiKey.isNotEmpty;
}
