// TODO Implement this library.
String capitalizeFirstLetter(String input) {
  if (input == null || input.isEmpty) {
    return input; // Return the input as-is if it's empty or null.
  }
  return input[0].toUpperCase() + input.substring(1);
}
