#include "stdint.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include "time.h"
#include "xxhash.h"

static double ts_to_secs(struct timespec* ts) {
  return (double)ts->tv_sec + (double)ts->tv_nsec / 1000000000.0;
}

double bench(void* buffer, int len) {
  int iteration_count = 1000000;
  uint64_t results[iteration_count];

  struct timespec start;
  struct timespec end;

  clock_gettime(CLOCK_MONOTONIC, &start);
  for (long i = 0; i < iteration_count; i++) {
    results[i] = XXH64(buffer, len, 0);
  }
  clock_gettime(CLOCK_MONOTONIC, &end);

  float secs = ts_to_secs(&end) - ts_to_secs(&start);

  printf("%llx\n", results[0]);

  double mbps = ((len * iteration_count) / 1000000) / secs;
  return mbps;
}

double average(int n, int payload_size) {
  double avg = 0.0;
  for (int i = 0; i < n; i++) {
    char* buffer = malloc(payload_size * sizeof(char));
    for (int j = 0; j < payload_size; j++) {
      buffer[j] = rand();
    }
    avg += bench(buffer, payload_size);
    free(buffer);
  }
  return avg / n;
}

int main() {
  double result8 = average(20, 8);
  printf("\n8B load -- MB/s: %.2f\n\n", result8);

  double result64 = average(20, 64);
  printf("\n64B load -- MB/s: %.2f\n\n", result64);

  double result128 = average(20, 128);
  printf("\n128B load -- MB/s: %.2f\n\n", result128);

  double result4k = average(20, 4000);
  printf("\n4k load -- MB/s: %.2f\n\n", result4k);
}