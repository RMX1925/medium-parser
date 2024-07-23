import 'package:myapp/modals/not_valid_data.dart';

NotValidMessage generateMessageForStatusCode(int statusCode, String url) {
  switch (statusCode) {
    case 200:
      return NotValidMessage(
        title: 'Success',
        message: 'The request was successful.',
        url: url,
      );
    case 400:
      return NotValidMessage(
        title: 'Bad Request',
        message:
            'The request could not be understood by the server due to malformed syntax.',
        url: url,
      );
    case 401:
      return NotValidMessage(
        title: 'Unauthorized',
        message: 'The request requires user authentication.',
        url: url,
      );
    case 403:
      return NotValidMessage(
        title: 'Forbidden',
        message:
            'The server understood the request, but refuses to authorize it.',
        url: url,
      );
    case 404:
      return NotValidMessage(
        title: 'Not Found',
        message: 'The server has not found anything matching the Request-URI.',
        url: url,
      );
    case 500:
      return NotValidMessage(
        title: 'Internal Server Error',
        message:
            'The server encountered an unexpected condition which prevented it from fulfilling the request.',
        url: url,
      );
    default:
      return NotValidMessage(
        title: 'Unknown Error',
        message: 'An unknown error has occurred.',
        url: url,
      );
  }
}

String getHeadHTML(String response) {
  return getSubStringWithTagName(response, "<head>", "</head>");
}

String getArticleHTML(String response) {
  return getSubStringWithTagName(response, "<article", "</article>");
}

String getSubStringWithTagName(String response, String tagName,
    [String? endTagName]) {
  return response.substring(response.indexOf(tagName),
      endTagName != null ? response.indexOf(endTagName) : null);
}
