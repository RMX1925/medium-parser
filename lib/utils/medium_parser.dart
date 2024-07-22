import 'package:myapp/modals/medium_modal.dart';
import 'package:html/parser.dart' as http;

class MediumArticleParser {
  /// Parses the HTML content and extracts the article data.
  MediumArticleData parse(String htmlContent) {
    final document = http.parse(htmlContent);

    final titleElement = document.querySelector('.pw-post-title');
    final authorElement = document.querySelector('.ab .ie a');
    final authorNameElement = document.querySelector('.ab .im p');
    final authorPhotoElement = document.querySelector('.ab .ie a .l img');
    final readTimeElement =
        document.querySelector('span[data-testid="storyReadTime"]');
    final publishDateElement =
        document.querySelector('span[data-testid="storyPublishDate"]');
    final clapCountElement =
        document.querySelector('.pw-multi-vote-count button');
    final responseCountElement = document.querySelector('.pw-responses-count');
    final contentElements = document.querySelectorAll('.meteredContent .gv');

    final title = titleElement?.text.trim() ?? '';
    final authorName = authorNameElement?.text.trim() ?? '';
    final authorUrl = authorElement?.attributes['href'] ?? '';
    final authorPhotoUrl = authorPhotoElement?.attributes['src'] ?? '';
    final readTime = readTimeElement?.text.trim() ?? '';
    final publishDate = publishDateElement?.text.trim() ?? '';
    final clapCount = int.tryParse(clapCountElement?.text.trim() ?? '0') ?? 0;
    final responseCount =
        int.tryParse(responseCountElement?.text.trim() ?? '0') ?? 0;
    final content = contentElements
        .map((element) => element.text.trim())
        .toList()
        .join('\n');

    return MediumArticleData(
      title: title,
      authorName: authorName,
      authorUrl: authorUrl,
      authorPhotoUrl: authorPhotoUrl,
      readTime: readTime,
      publishDate: publishDate,
      clapCount: clapCount,
      responseCount: responseCount,
      content: content,
    );
  }
}
