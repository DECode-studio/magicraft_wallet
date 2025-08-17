bool isEmail(String input) {
  final RegExp emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  return emailRegex.hasMatch(input);
}

bool isValidUrl(String url) {
  const urlPattern = r'^(https?:\/\/)?([a-zA-Z0-9.-]+)(\.[a-zA-Z]{2,})([\/\w .-]*)*\/?(\?.*)?$';
  final regExp = RegExp(urlPattern);

  return regExp.hasMatch(url);
}