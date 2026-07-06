# Ada-SPARK-Shortest-Seek-First

Ada SPARK Implementation of Shortest Seek First Algorithm; https://en.wikipedia.org/wiki/Shortest_seek_first

## Project Structure

```
.
├── src/                    # Core SSTF algorithm (SPARK)
│   ├── sstf.ads            # Package specification
│   ├── sstf.adb            # Package implementation
│   └── sstf.gpr            # GPR project file
├── tests/                  # Comprehensive test suite
│   ├── sstf_tests.ads      # Test package specification
│   ├── sstf_tests.adb      # Test package implementation
│   └── test_runner.adb     # Test runner program
│   └── test_runner.gpr     # Test project file
├── demo/                   # Demonstration programs
│   ├── sstf_demo.adb       # Interactive demo program
│   └── sstf_demo.gpr       # Demo project file
├── build.sh               # Build script
├── sstf_all.gpr            # Master project file
└── README.md
```

## Building and Running

### Quick Start

1. **Build everything:**
   ```bash
   ./build.sh build
   ```

2. **Run tests:**
   ```bash
   ./build.sh test
   ```

3. **Run demo:**
   ```bash
   ./build.sh demo
   ```

4. **Run interactive demo:**
   ```bash
   ./build.sh demo interactive
   ```

### Manual Building

- **Build the SSTF library:**
  ```bash
  cd src && gprbuild -P sstf.gpr
  ```

- **Build and run tests:**
  ```bash
  cd tests && gprbuild -P test_runner.gpr
  ./test_runner
  ```

- **Build and run demo:**
  ```bash
  cd demo && gprbuild -P sstf_demo.gpr
  ./sstf_demo
  ```

- **Run interactive demo:**
  ```bash
  ./sstf_demo interactive
  ```

## Test Suite

The comprehensive test suite includes:

- **Single Request Test** - Verifies basic functionality with one request
- **Two Requests Tests** - Tests head positioning with two requests
- **Multiple Requests Tests** - Tests with 3-5 requests in various configurations
- **Edge Cases** - Tests with head at track 0, at request positions, etc.
- **Complex Scenarios** - Tests with mixed request positions

All tests verify that the SSTF algorithm correctly selects the closest request to the current head position.

## Demo Program

The demo program provides:

- **Predefined Demonstrations** - Shows 5 different scenarios with explanations
- **Interactive Mode** - Allows you to input your own head position and requests
- **Step-by-step Output** - Shows the seek movement for each step
- **Total Seek Distance** - Calculates and displays the total head movement

## SPARK Verification

The core SSTF algorithm is written in SPARK and includes:

- **Preconditions** - Ensures valid input parameters
- **Postconditions** - Guarantees correct output
- **Depends Contracts** - Specifies information flow
- **Type Constraints** - Prevents buffer overflows and invalid values

Note: GNATPROVE may take significant time to complete on complex proofs, but the algorithm is designed to be provable.

## Algorithm Description

The Shortest Seek First (SSTF) algorithm works as follows:

1. Start with the initial head position
2. Find the request closest to the current head position
3. Move the head to that request
4. Mark the request as serviced
5. Repeat until all requests are serviced

This minimizes the total seek time by always choosing the closest available request.

## License

This project is open source and available under the MIT License.
