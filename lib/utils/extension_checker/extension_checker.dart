String getFileExtension(String url) {
  // Check if the URL contains a file extension
  if (url.contains('.')) {
    // Split the URL by '/' and get the last part (file name)
    String fileName = url.split('/').last;
    // Split the file name by '.' and get the last part (extension)
    return fileName.split('.').last;
  }
  // Return empty if no extension is found
  return '';
}