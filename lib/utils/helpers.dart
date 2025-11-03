String removeHtmlTags(String htmlText) {
return htmlText.replaceAll(RegExp(r'<[^>]*>'), '').replaceAll('&nbsp;', ' ').trim();
}