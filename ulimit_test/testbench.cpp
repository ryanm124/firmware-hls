
#include "test.h"

int main() {

  static int testArray[entries];

  for (int i = 0; i < entries; i++) {
    testArray[i] = i;
  }

  testFunction(testArray);

  int error = 0; // Error count

  for (int i = 0; i < entries; i++) {
    error += (testArray[i] == (i + 1)) ? 0 : 1;
  }

  return error;
}
