-- Test package body for SSTF algorithm
-- Comprehensive test suite for the Shortest Seek First algorithm

package body SSTF_Tests with SPARK_Mode is

   procedure Run_All_Tests (Results : out Test_Case_Array) is
   begin
      -- Test Case 1: Single request
      declare
         Test1_Requests : Track_Array(1..1) := (1 => 100);
         Test1_Expected : Track_Array(1..1) := (1 => 100);
         Test1_Actual : Track_Array(1..1);
      begin
         Results(1) := (
            Name => "Single Request Test                     ",
            Initial => 50,
            Requests => Test1_Requests,
            Expected => Test1_Expected,
            Result => Pass,
            Actual => Test1_Actual
         );
         Get_SSTF_Schedule(50, Test1_Requests, Test1_Actual);
         
         -- Verify result
         if Test1_Actual(1) /= Test1_Expected(1) then
            Results(1).Result := Fail;
         end if;
      end;

      -- Test Case 2: Two requests, head in middle
      declare
         Test2_Requests : Track_Array(1..2) := (1 => 10, 2 => 90);
         Test2_Expected : Track_Array(1..2) := (1 => 10, 2 => 90);
         Test2_Actual : Track_Array(1..2);
      begin
         Results(2) := (
            Name => "Two Requests - Head in Middle            ",
            Initial => 50,
            Requests => Test2_Requests,
            Expected => Test2_Expected,
            Result => Pass,
            Actual => Test2_Actual
         );
         Get_SSTF_Schedule(50, Test2_Requests, Test2_Actual);
         
         -- Verify result (should go to 10 first, then 90)
         if Test2_Actual(1) /= 10 or Test2_Actual(2) /= 90 then
            Results(2).Result := Fail;
         end if;
      end;

      -- Test Case 3: Two requests, head at start
      declare
         Test3_Requests : Track_Array(1..2) := (1 => 50, 2 => 100);
         Test3_Expected : Track_Array(1..2) := (1 => 50, 2 => 100);
         Test3_Actual : Track_Array(1..2);
      begin
         Results(3) := (
            Name => "Two Requests - Head at Start             ",
            Initial => 0,
            Requests => Test3_Requests,
            Expected => Test3_Expected,
            Result => Pass,
            Actual => Test3_Actual
         );
         Get_SSTF_Schedule(0, Test3_Requests, Test3_Actual);
         
         -- Verify result (should go to 50 first, then 100)
         if Test3_Actual(1) /= 50 or Test3_Actual(2) /= 100 then
            Results(3).Result := Fail;
         end if;
      end;

      -- Test Case 4: Three requests, testing closest selection
      declare
         Test4_Requests : Track_Array(1..3) := (1 => 20, 2 => 80, 3 => 120);
         Test4_Expected : Track_Array(1..3) := (1 => 80, 2 => 120, 3 => 20);
         Test4_Actual : Track_Array(1..3);
      begin
         Results(4) := (
            Name => "Three Requests - Closest First            ",
            Initial => 100,
            Requests => Test4_Requests,
            Expected => Test4_Expected,
            Result => Pass,
            Actual => Test4_Actual
         );
         Get_SSTF_Schedule(100, Test4_Requests, Test4_Actual);
         
         -- Verify result (from 100: closest is 80, then 120, then 20)
         if Test4_Actual(1) /= 80 or Test4_Actual(2) /= 120 or Test4_Actual(3) /= 20 then
            Results(4).Result := Fail;
         end if;
      end;

      -- Test Case 5: Requests on both sides of head
      declare
         Test5_Requests : Track_Array(1..4) := (1 => 10, 2 => 30, 3 => 70, 4 => 90);
         Test5_Expected : Track_Array(1..4) := (1 => 30, 2 => 10, 3 => 70, 4 => 90);
         Test5_Actual : Track_Array(1..4);
      begin
         Results(5) := (
            Name => "Four Requests - Mixed Positions          ",
            Initial => 50,
            Requests => Test5_Requests,
            Expected => Test5_Expected,
            Result => Pass,
            Actual => Test5_Actual
         );
         Get_SSTF_Schedule(50, Test5_Requests, Test5_Actual);
         
         -- Verify result (from 50: closest is 30, then 10, then 70, then 90)
         if Test5_Actual(1) /= 30 or Test5_Actual(2) /= 10 or 
            Test5_Actual(3) /= 70 or Test5_Actual(4) /= 90 then
            Results(5).Result := Fail;
         end if;
      end;

      -- Test Case 6: All requests on one side
      declare
         Test6_Requests : Track_Array(1..3) := (1 => 10, 2 => 20, 3 => 30);
         Test6_Expected : Track_Array(1..3) := (1 => 10, 2 => 20, 3 => 30);
         Test6_Actual : Track_Array(1..3);
      begin
         Results(6) := (
            Name => "Three Requests - All Left of Head        ",
            Initial => 50,
            Requests => Test6_Requests,
            Expected => Test6_Expected,
            Result => Pass,
            Actual => Test6_Actual
         );
         Get_SSTF_Schedule(50, Test6_Requests, Test6_Actual);
         
         -- Verify result (should go 10, 20, 30 - all left of head)
         if Test6_Actual(1) /= 10 or Test6_Actual(2) /= 20 or Test6_Actual(3) /= 30 then
            Results(6).Result := Fail;
         end if;
      end;

      -- Test Case 7: All requests on the other side
      declare
         Test7_Requests : Track_Array(1..3) := (1 => 70, 2 => 80, 3 => 90);
         Test7_Expected : Track_Array(1..3) := (1 => 70, 2 => 80, 3 => 90);
         Test7_Actual : Track_Array(1..3);
      begin
         Results(7) := (
            Name => "Three Requests - All Right of Head       ",
            Initial => 50,
            Requests => Test7_Requests,
            Expected => Test7_Expected,
            Result => Pass,
            Actual => Test7_Actual
         );
         Get_SSTF_Schedule(50, Test7_Requests, Test7_Actual);
         
         -- Verify result (should go 70, 80, 90 - all right of head)
         if Test7_Actual(1) /= 70 or Test7_Actual(2) /= 80 or Test7_Actual(3) /= 90 then
            Results(7).Result := Fail;
         end if;
      end;

      -- Test Case 8: Head exactly at a request position
      declare
         Test8_Requests : Track_Array(1..3) := (1 => 50, 2 => 100, 3 => 150);
         Test8_Expected : Track_Array(1..3) := (1 => 50, 2 => 100, 3 => 150);
         Test8_Actual : Track_Array(1..3);
      begin
         Results(8) := (
            Name => "Head at Request Position                 ",
            Initial => 50,
            Requests => Test8_Requests,
            Expected => Test8_Expected,
            Result => Pass,
            Actual => Test8_Actual
         );
         Get_SSTF_Schedule(50, Test8_Requests, Test8_Actual);
         
         -- Verify result (head at 50, so 50 first, then 100, then 150)
         if Test8_Actual(1) /= 50 or Test8_Actual(2) /= 100 or Test8_Actual(3) /= 150 then
            Results(8).Result := Fail;
         end if;
      end;

      -- Test Case 9: Larger set of requests
      declare
         Test9_Requests : Track_Array(1..5) := (1 => 10, 2 => 50, 3 => 100, 4 => 150, 5 => 200);
         Test9_Expected : Track_Array(1..5) := (1 => 50, 2 => 10, 3 => 100, 4 => 150, 5 => 200);
         Test9_Actual : Track_Array(1..5);
      begin
         Results(9) := (
            Name => "Five Requests - Comprehensive Test        ",
            Initial => 75,
            Requests => Test9_Requests,
            Expected => Test9_Expected,
            Result => Pass,
            Actual => Test9_Actual
         );
         Get_SSTF_Schedule(75, Test9_Requests, Test9_Actual);
         
         -- Verify result (from 75: closest is 50, then 10, then 100, 150, 200)
         if Test9_Actual(1) /= 50 or Test9_Actual(2) /= 10 or 
            Test9_Actual(3) /= 100 or Test9_Actual(4) /= 150 or Test9_Actual(5) /= 200 then
            Results(9).Result := Fail;
         end if;
      end;

      -- Test Case 10: Edge case - head at 0
      declare
         Test10_Requests : Track_Array(1..2) := (1 => 50, 2 => 100);
         Test10_Expected : Track_Array(1..2) := (1 => 50, 2 => 100);
         Test10_Actual : Track_Array(1..2);
      begin
         Results(10) := (
            Name => "Head at Track 0                         ",
            Initial => 0,
            Requests => Test10_Requests,
            Expected => Test10_Expected,
            Result => Pass,
            Actual => Test10_Actual
         );
         Get_SSTF_Schedule(0, Test10_Requests, Test10_Actual);
         
         -- Verify result
         if Test10_Actual(1) /= 50 or Test10_Actual(2) /= 100 then
            Results(10).Result := Fail;
         end if;
      end;

      -- Remaining test cases are placeholders
      for I in 11..Max_Test_Cases loop
         Results(I) := (
            Name => "Unused Test Case                         ",
            Initial => 0,
            Requests => (others => 0),
            Expected => (others => 0),
            Result => Pass,
            Actual => (others => 0)
         );
      end loop;

   end Run_All_Tests;

   procedure Print_Results (Results : in Test_Case_Array) is
   begin
      Put_Line("=================================================");
      Put_Line("SSTF Algorithm Test Results");
      Put_Line("=================================================");
      Put_Line("");
      
      for I in Results'Range loop
         case Results(I).Result is
            when Pass =>
               Put_Line("[PASS] " & Results(I).Name);
            when Fail =>
               Put_Line("[FAIL] " & Results(I).Name);
               Put_Line("       Expected: ");
               for J in Results(I).Expected'Range loop
                  Put(" " & Track_Index'Image(Results(I).Expected(J)));
               end loop;
               New_Line;
               Put_Line("       Actual:   ");
               for J in Results(I).Actual'Range loop
                  Put(" " & Track_Index'Image(Results(I).Actual(J)));
               end loop;
               New_Line;
            when Error =>
               Put_Line("[ERROR] " & Results(I).Name);
         end case;
      end loop;
      
      Put_Line("");
      Put_Line("=================================================");
      
      if All_Passed(Results) then
         Put_Line("ALL TESTS PASSED!");
      else
         Put_Line("SOME TESTS FAILED!");
      end if;
      
      Put_Line("=================================================");
   end Print_Results;

   function All_Passed (Results : in Test_Case_Array) return Boolean is
      All_Good : Boolean := True;
   begin
      for I in Results'Range loop
         if Results(I).Result /= Pass then
            All_Good := False;
            exit;
         end if;
      end loop;
      return All_Good;
   end All_Passed;

   -- Helper procedures for output
   procedure Put_Line (Item : String) is
   begin
      Ada.Text_IO.Put_Line(Item);
   end Put_Line;

   procedure Put (Item : String) is
   begin
      Ada.Text_IO.Put(Item);
   end Put;

   procedure New_Line is
   begin
      Ada.Text_IO.New_Line;
   end New_Line;

end SSTF_Tests;
