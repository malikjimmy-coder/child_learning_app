import 'dart:convert';
import 'package:http/http.dart' as http;

class PexelsService {
  static const String _apiKey = 'CSf2yUOHtjzPp02u3Xr5XkyPLW1WoddJ2IDceFrNVFDqwZ4H66CwcxUk';
  static const String _baseUrl = 'https://api.pexels.com/v1';

  /// Get kid-friendly image URL with better search terms
  static Future<String?> getImageUrl(String query) async {
    // Better search terms for kids
    String improvedQuery = _getKidFriendlyQuery(query);

    try {
      print('🔍 Fetching image for: $improvedQuery');

      final response = await http.get(
        Uri.parse('$_baseUrl/search?query=$improvedQuery&per_page=3&orientation=landscape'),
        headers: {
          'Authorization': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['photos'] != null && (data['photos'] as List).isNotEmpty) {
          // Get medium quality image (better for kids - colorful and clear)
          final imageUrl = data['photos'][0]['src']['medium'];
          print('✅ Image found: $imageUrl');
          return imageUrl;
        }
      }
    } catch (e) {
      print('❌ Error: $e');
    }

    return null;
  }

  /// Improve search query for kid-friendly results
  static String _getKidFriendlyQuery(String word) {
    word = word.toLowerCase().trim();

    // Special cases for better kid images
    final specialQueries = {
      'apple': 'red apple fruit cartoon',
      'ball': 'colorful ball toy kids',
      'cat': 'cute cat kitten pet',
      'dog': 'cute dog puppy pet',
      'elephant': 'elephant cartoon animal',
      'fish': 'colorful fish tropical',
      'grapes': 'purple grapes fruit bunch',
      'house': 'cartoon house building',
      'ice cream': 'colorful ice cream cone',
      'jug': 'water jug pitcher',
      'kite': 'colorful kite flying',
      'lion': 'lion cartoon animal king',
      'monkey': 'cute monkey cartoon',
      'nest': 'bird nest eggs',
      'orange': 'orange fruit citrus',
      'parrot': 'colorful parrot bird',
      'queen': 'queen crown cartoon',
      'rabbit': 'cute rabbit bunny',
      'sun': 'bright sun cartoon',
      'tiger': 'tiger cartoon animal',
      'umbrella': 'colorful umbrella rain',
      'van': 'colorful van vehicle',
      'watch': 'wrist watch clock',
      'xylophone': 'colorful xylophone musical',
      'yak': 'yak animal himalayan',
      'zebra': 'zebra stripes animal',
    };

    return specialQueries[word] ?? '$word cartoon colorful kids';
  }
}