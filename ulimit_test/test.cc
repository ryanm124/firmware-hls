
#include "test.h"

// Test function that adds 1 to every array entry

void testFunction(int array[entries]) {

#pragma HLS array_partition variable=array complete dim=0

for (int i = 0; i < entries; i++) {
    array[i] += 1;
  }

}
