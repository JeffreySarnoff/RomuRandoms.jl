/*  Written in 2015 by Sebastiano Vigna (vigna@acm.org)

To the extent possible under law, the author has dedicated all copyright
and related and neighboring rights to this software to the public domain
worldwide. This software is distributed without any warranty.

See <http://creativecommons.org/publicdomain/zero/1.0/>. */

#include <stdint.h>

/* This is a fixed-increment version of Java 8's SplittableRandom generator
   See http://dx.doi.org/10.1145/2714064.2660195 and 
   http://docs.oracle.com/javase/8/docs/api/java/util/SplittableRandom.html

   It is a very fast generator passing BigCrush, and it can be useful if
   for some reason you absolutely want 64 bits of state. */

static uint64_t x; /* The state can be seeded with any value. */

uint64_t next() {
	uint64_t z = (x += 0x9e3779b97f4a7c15);
	z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9;
	z = (z ^ (z >> 27)) * 0x94d049bb133111eb;
	return z ^ (z >> 31);
}


/* This is a fixed-increment version of Java 8's SplittableRandom generator
See http://dx.doi.org/10.1145/2714064.2660195 and
http://docs.oracle.com/javase/8/docs/api/java/util/SplittableRandom.html
It is a very fast generator passing BigCrush, and it can be useful if
for some reason you absolutely want 64 bits of state. */

static uint64_t sState; /* The state can be seeded with any value. */

uint64_t splitMix64 () {
uint64_t z = (sState += 0x9e3779b97f4a7c15);
z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9;
z = (z ^ (z >> 27)) * 0x94d049bb133111eb;
return z ^ (z >> 31);
}


// Copyright 2020 Mark A. Overton
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
#include <stdint.h>
static uint32_t sState; // State can be seeded with any value, including 0.

uint32_t splitMix32 () {
	sState = 1664525u * (sState + 314159265u); // Multiplier is from Knuth.
	uint32_t z = sState;
	z = (z ^ (z >> 15)) * 0x5ce4e5b9u;
	z = (z ^ (z >> 13)) * 0x1331c1ebu;
	return z ^ (z >> 15);
}

