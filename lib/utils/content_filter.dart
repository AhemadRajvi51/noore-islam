class ContentFilter {
  static Future<bool> checkContent(String text) async {
    final keywords = await ParentalControlService().getRestrictedKeywords();
    final lowerText = text.toLowerCase();
    return keywords.any((keyword) => lowerText.contains(keyword.toLowerCase()));
  }

  static Future<void> filterUserGeneratedContent() async {
    if(await ParentalControlService().isParentalControlEnabled()) {
      // Implement your content moderation logic here
    }
  }
  
  // ignore: non_constant_identifier_names
  static ParentalControlService() {}
}