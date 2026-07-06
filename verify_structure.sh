#!/bin/bash

# Structure verification script for SSTF Project
# This script verifies that all necessary files are in place

echo "SSTF Project Structure Verification"
echo "===================================="
echo ""

# Expected files
EXPECTED_FILES=(
    "src/sstf.ads"
    "src/sstf.adb"
    "src/sstf.gpr"
    "tests/sstf_tests.ads"
    "tests/sstf_tests.adb"
    "tests/test_runner.adb"
    "tests/test_runner.gpr"
    "demo/sstf_demo.adb"
    "demo/sstf_demo.gpr"
    "sstf_all.gpr"
    "build.sh"
    "Makefile"
    "README.md"
)

PASSED=0
FAILED=0

for file in "${EXPECTED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "[✓] $file"
        ((PASSED++))
    else
        echo "[✗] $file - MISSING"
        ((FAILED++))
    fi
done

echo ""
echo "Summary:"
echo "  Passed: $PASSED"
echo "  Failed: $FAILED"

if [ $FAILED -eq 0 ]; then
    echo ""
    echo "✓ All expected files are present!"
    echo ""
    echo "To build and run:"
    echo "  ./build.sh test    - Run the comprehensive test suite"
    echo "  ./build.sh demo    - Run the demonstration program"
    echo "  ./build.sh build   - Build all components"
    exit 0
else
    echo ""
    echo "✗ Some files are missing!"
    exit 1
fi
