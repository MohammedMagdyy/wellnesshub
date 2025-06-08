String simplifyErrorMessage(String original) {
  if (original.contains('500')) {
    return 'Server issues - please try again later';
  }
  if (original.contains('timeout')) {
    return 'Request took too long - check your connection';
  }
  if (original.contains('connection')) {
    return 'No internet connection';
  }
  return 'Something went wrong - please try again';
}