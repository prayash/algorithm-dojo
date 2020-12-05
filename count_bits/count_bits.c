#include <stdio.h>

// countBits
// For a given integer value will return the number of bits that are set to 1 (on).
// Example: For a value of 3 (0x11), return 2.
// int countBits(int value):
// gcc -Wall count_bits.c -o count_bits

int countBits(int value) {
  int bits = 0;
  int mask = 0x01;

  for (int i = 0; i < 32 && mask <= (unsigned)value; i++) {
    if ((value & mask) != 0) {
      bits++;
    }

    mask = mask << 1;
  }

  // Alternative
  // unsigned v = (unsigned) value;
  // while (v) {
  //   bits = v & mask;
  //   v >>= 1;
  // }

  return bits;
}

int main() {
  int testValues[] = {0, 1, 255, 23453, 9245873, 33, 123, -1, -3};

  for (int i = 0; i < sizeof(testValues)/sizeof(*testValues);i++) {
    int value = testValues[i];
    printf("countBits(%d) = %d\n", value, countBits(value));
  }

  return 0;
}