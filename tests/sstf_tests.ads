-- Test package specification for SSTF algorithm
-- This provides test cases and verification procedures

package SSTF_Tests with SPARK_Mode is

   -- Import the SSTF package
   with SSTF;
   use SSTF;

   -- Test result type
   type Test_Result is (Pass, Fail, Error);

   -- Test case record
   type Test_Case is record
      Name        : String(1..50);
      Initial     : Track_Index;
      Requests    : Track_Array(1..10);  -- Max 10 requests per test case
      Expected    : Track_Array(1..10);
      Result      : Test_Result;
      Actual      : Track_Array(1..10);
   end record;

   -- Array of test cases
   Max_Test_Cases : constant := 20;
   type Test_Case_Array is array (1..Max_Test_Cases) of Test_Case;

   -- Procedure to run all tests
   procedure Run_All_Tests (Results : out Test_Case_Array);

   -- Procedure to print test results
   procedure Print_Results (Results : in Test_Case_Array);

   -- Function to check if all tests passed
   function All_Passed (Results : in Test_Case_Array) return Boolean;

end SSTF_Tests;
