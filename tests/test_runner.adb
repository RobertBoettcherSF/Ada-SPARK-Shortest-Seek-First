-- Test Runner for SSTF Algorithm
-- This program runs the comprehensive test suite and reports results

with Ada.Text_IO;
with SSTF_Tests;

procedure Test_Runner is

   Results : SSTF_Tests.Test_Case_Array;

begin
   Ada.Text_IO.Put_Line("SSTF Algorithm Test Runner");
   Ada.Text_IO.Put_Line("==========================");
   Ada.Text_IO.New_Line;
   
   -- Run all tests
   SSTF_Tests.Run_All_Tests(Results);
   
   -- Print results
   SSTF_Tests.Print_Results(Results);
   
   -- Exit with appropriate status
   if SSTF_Tests.All_Passed(Results) then
      Ada.Text_IO.Put_Line("Test runner completed: ALL TESTS PASSED");
   else
      Ada.Text_IO.Put_Line("Test runner completed: SOME TESTS FAILED");
   end if;

end Test_Runner;
