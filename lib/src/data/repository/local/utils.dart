String textLimit(String text, int limit) {
  if (text.length > limit) {
    return text.substring(0, limit - 3) + ' ...';
  } else {
    return text;
  }
}