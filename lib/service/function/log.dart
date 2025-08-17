void printLog(dynamic text) {
  var data = text.toString();

  const int chunkSize = 800;
  int start = 0;
  while (start < data.length) {
    int end =
        (start + chunkSize < data.length) ? start + chunkSize : data.length;

    print(data.substring(start, end));
    start = end;
  }
}
