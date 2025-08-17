int getInt(dynamic text) {
  var data = text.toString();
  var value = data.replaceAll(RegExp(r'[^0-9]'), '');

  return int.parse(value);
}

String removeCustomerPrefix(String email) {
  var status = email.startsWith("customer.");

  if (status) {
    return email.replaceFirst("customer.", "");
  }
  return email;
}

String getErrorMessage(String input) {
  int startIndex =
      input.indexOf('execution reverted: ') + 'execution reverted: '.length;
  int endIndex = input.lastIndexOf('"');

  if (startIndex != -1 && endIndex != -1 && startIndex < endIndex) {
    return input.substring(startIndex, endIndex);
  }

  return 'Error message not found';
}

String buildObscuredText(String text) {
  return text.split(' ').map((_) => '●●●●').join(' ');
}

String safeGet(List<String> list, int index) {
  return index < list.length ? list[index] : '';
}
