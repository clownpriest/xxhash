package main

import (
	"crypto/rand"
	"fmt"
	"time"

	"github.com/cespare/xxhash"
)

func bench(payload []byte) float64 {
	xx := xxhash.New()
	iteration_count := 1000000
	results := [1000000]uint64{}

	start := time.Now()
	for i := 0; i < iteration_count; i++ {
		xx.Write(payload)
		results[i] = xx.Sum64()
	}
	t := time.Now()
	secs := t.Sub(start).Seconds()
	fmt.Println(results[0])
	mbps := float64(len(payload)*iteration_count/1000000) / secs
	return mbps
}

func average(n int, loadSize uint) float64 {
	avg := 0.0
	for i := 0; i < n; i++ {
		x := make([]byte, loadSize)
		rand.Read(x[:])
		avg += bench(x)
	}
	return avg / float64(n)
}

func main() {

	result8 := average(20, 8)
	fmt.Printf("\n8B load -- MB/s: %f\n\n", result8)

	result64 := average(20, 64)
	fmt.Printf("\n64B load -- MB/s: %f\n\n", result64)

	result128 := average(20, 128)
	fmt.Printf("\n128B load -- MB/s: %f\n\n", result128)

	result4k := average(20, 4000)
	fmt.Printf("\n4KB load -- MB/s: %f\n\n", result4k)

}
