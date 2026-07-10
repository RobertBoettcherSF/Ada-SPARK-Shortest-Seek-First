-- Test package body for SSTF algorithm
-- Comprehensive test suite for the Shortest Seek First algorithm

with Ada.Text_IO;

package body SSTF_Tests is

   procedure Run_All_Tests (Results : out Test_Case_Array) is
   begin
      -- Test Case 1: Single request
      declare
         Test1_Requests : constant Track_Array(1..1) := (1 => 100);
         Test1_Expected : constant Track_Array(1..1) := (1 => 100);
         Test1_Actual : Track_Array(1..1);
      begin
         Results(1) := (
            Name => "Single Request Test                                    ",
            Initial => 50,
            Request_Count => 1,
            Requests => (1 => 100, others => 0),
            Expected => (1 => 100, others => 0),
            Result => Pass,
            Actual => (others => 0)
         );
         Get_SSTF_Schedule(50, Test1_Requests, Test1_Actual);
         Results(1).Actual(1) := Test1_Actual(1);
         
         if Test1_Actual(1) /= Test1_Expected(1) then
            Results(1).Result := Fail;
         end if;
      end;

      -- Test Case 2: Two requests, head in middle
      declare
         Test2_Requests : constant Track_Array(1..2) := (1 => 10, 2 => 90);
         Test2_Expected : constant Track_Array(1..2) := (1 => 10, 2 => 90);
         Test2_Actual : Track_Array(1..2);
      begin
         Results(2) := (
            Name => "Two Requests - Head in Middle                       ",
            Initial => 50,
            Request_Count => 2,
            Requests => (1 => 10, 2 => 90, others => 0),
            Expected => (1 => 10, 2 => 90, others => 0),
            Result => Pass,
            Actual => (others => 0)
         );
         Get_SSTF_Schedule(50, Test2_Requests, Test2_Actual);
         Results(2).Actual(1..2) := Test2_Actual(1..2);
         
         if Test2_Actual(1) /= Test2_Expected(1) or Test2_Actual(2) /= Test2_Expected(2) then
            Results(2).Result := Fail;
         end if;
      end;

      -- Test Case 3: Two requests, head at start
      declare
         Test3_Requests : constant Track_Array(1..2) := (1 => 50, 2 => 100);
         Test3_Expected : constant Track_Array(1..2) := (1 => 50, 2 => 100);
         Test3_Actual : Track_Array(1..2);
      begin
         Results(3) := (
            Name => "Two Requests - Head at Start                        ",
            Initial => 0,
            Request_Count => 2,
            Requests => (1 => 50, 2 => 100, others => 0),
            Expected => (1 => 50, 2 => 100, others => 0),
            Result => Pass,
            Actual => (others => 0)
         );
         Get_SSTF_Schedule(0, Test3_Requests, Test3_Actual);
         Results(3).Actual(1..2) := Test3_Actual(1..2);
         
         if Test3_Actual(1) /= Test3_Expected(1) or Test3_Actual(2) /= Test3_Expected(2) then
            Results(3).Result := Fail;
         end if;
      end;

      -- Test Case 4: Three requests, testing closest selection
      declare
         Test4_Requests : constant Track_Array(1..3) := (1 => 20, 2 => 80, 3 => 120);
         Test4_Expected : constant Track_Array(1..3) := (1 => 80, 2 => 120, 3 => 20);
         Test4_Actual : Track_Array(1..3);
      begin
         Results(4) := (
            Name => "Three Requests - Closest First                       ",
            Initial => 100,
            Request_Count => 3,
            Requests => (1 => 20, 2 => 80, 3 => 120, others => 0),
            Expected => (1 => 80, 2 => 120, 3 => 20, others => 0),
            Result => Pass,
            Actual => (others => 0)
         );
         Get_SSTF_Schedule(100, Test4_Requests, Test4_Actual);
         Results(4).Actual(1..3) := Test4_Actual(1..3);
         
         if Test4_Actual(1) /= Test4_Expected(1) or Test4_Actual(2) /= Test4_Expected(2) or Test4_Actual(3) /= Test4_Expected(3) then
            Results(4).Result := Fail;
         end if;
      end;

      -- Test Case 5: Requests on both sides of head
      declare
         Test5_Requests : constant Track_Array(1..4) := (1 => 10, 2 => 30, 3 => 70, 4 => 90);
         Test5_Expected : constant Track_Array(1..4) := (1 => 30, 2 => 10, 3 => 70, 4 => 90);
         Test5_Actual : Track_Array(1..4);
      begin
         Results(5) := (
            Name => "Four Requests - Mixed Positions                     ",
            Initial => 50,
            Request_Count => 4,
            Requests => (1 => 10, 2 => 30, 3 => 70, 4 => 90, others => 0),
            Expected => (1 => 30, 2 => 10, 3 => 70, 4 => 90, others => 0),
            Result => Pass,
            Actual => (others => 0)
         );
         Get_SSTF_Schedule(50, Test5_Requests, Test5_Actual);
         Results(5).Actual(1..4) := Test5_Actual(1..4);
         
         if Test5_Actual(1) /= Test5_Expected(1) or Test5_Actual(2) /= Test5_Expected(2) or 
            Test5_Actual(3) /= Test5_Expected(3) or Test5_Actual(4) /= Test5_Expected(4) then
            Results(5).Result := Fail;
         end if;
      end;

      -- Test Case 6: All requests on one side
      declare
         Test6_Requests : constant Track_Array(1..3) := (1 => 10, 2 => 20, 3 => 30);
         Test6_Expected : constant Track_Array(1..3) := (1 => 10, 2 => 20, 3 => 30);
         Test6_Actual : Track_Array(1..3);
      begin
         Results(6) := (
            Name => "Three Requests - All Left of Head                   ",
            Initial => 50,
            Request_Count => 3,
            Requests => (1 => 10, 2 => 20, 3 => 30, others => 0),
            Expected => (1 => 10, 2 => 20, 3 => 30, others => 0),
            Result => Pass,
            Actual => (others => 0)
         );
         Get_SSTF_Schedule(50, Test6_Requests, Test6_Actual);
         Results(6).Actual(1..3) := Test6_Actual(1..3);
         
         if Test6_Actual(1) /= Test6_Expected(1) or Test6_Actual(2) /= Test6_Expected(2) or Test6_Actual(3) /= Test6_Expected(3) then
            Results(6).Result := Fail;
         end if;
      end;

      -- Test Case 7: All requests on the other side
      declare
         Test7_Requests : constant Track_Array(1..3) := (1 => 70, 2 => 80, 3 => 90);
         Test7_Expected : constant Track_Array(1..3) := (1 => 70, 2 => 80, 3 => 90);
         Test7_Actual : Track_Array(1..3);
      begin
         Results(7) := (
            Name => "Three Requests - All Right of Head                  ",
            Initial => 50,
            Request_Count => 3,
            Requests => (1 => 70, 2 => 80, 3 => 90, others => 0),
            Expected => (1 => 70, 2 => 80, 3 => 90, others => 0),
            Result => Pass,
            Actual => (others => 0)
         );
         Get_SSTF_Schedule(50, Test7_Requests, Test7_Actual);
         Results(7).Actual(1..3) := Test7_Actual(1..3);
         
         if Test7_Actual(1) /= Test7_Expected(1) or Test7_Actual(2) /= Test7_Expected(2) or Test7_Actual(3) /= Test7_Expected(3) then
            Results(7).Result := Fail;
         end if;
      end;

      -- Test Case 8: Head exactly at a request position
      declare
         Test8_Requests : constant Track_Array(1..3) := (1 => 50, 2 => 100, 3 => 150);
         Test8_Expected : constant Track_Array(1..3) := (1 => 50, 2 => 100, 3 => 150);
         Test8_Actual : Track_Array(1..3);
      begin
         Results(8) := (
            Name => "Head at Request Position                            ",
            Initial => 50,
            Request_Count => 3,
            Requests => (1 => 50, 2 => 100, 3 => 150, others => 0),
            Expected => (1 => 50, 2 => 100, 3 => 150, others => 0),
            Result => Pass,
            Actual => (others => 0)
         );
         Get_SSTF_Schedule(50, Test8_Requests, Test8_Actual);
         Results(8).Actual(1..3) := Test8_Actual(1..3);
         
         if Test8_Actual(1) /= Test8_Expected(1) or Test8_Actual(2) /= Test8_Expected(2) or Test8_Actual(3) /= Test8_Expected(3) then
            Results(8).Result := Fail;
         end if;
      end;

      -- Test Case 9: Larger set of requests
      declare
         Test9_Requests : constant Track_Array(1..5) := (1 => 10, 2 => 50, 3 => 100, 4 => 150, 5 => 200);
         Test9_Expected : constant Track_Array(1..5) := (1 => 50, 2 => 10, 3 => 100, 4 => 150, 5 => 200);
         Test9_Actual : Track_Array(1..5);
      begin
         Results(9) := (
            Name => "Five Requests - Comprehensive Test                   ",
            Initial => 75,
            Request_Count => 5,
            Requests => (1 => 10, 2 => 50, 3 => 100, 4 => 150, 5 => 200, others => 0),
            Expected => (1 => 50, 2 => 10, 3 => 100, 4 => 150, 5 => 200, others => 0),
            Result => Pass,
            Actual => (others => 0)
         );
         Get_SSTF_Schedule(75, Test9_Requests, Test9_Actual);
         Results(9).Actual(1..5) := Test9_Actual(1..5);
         
         if Test9_Actual(1) /= Test9_Expected(1) or Test9_Actual(2) /= Test9_Expected(2) or 
            Test9_Actual(3) /= Test9_Expected(3) or Test9_Actual(4) /= Test9_Expected(4) or Test9_Actual(5) /= Test9_Expected(5) then
            Results(9).Result := Fail;
         end if;
      end;

      -- Test Case 10: Edge case - head at 0
      declare
         Test10_Requests : constant Track_Array(1..2) := (1 => 50, 2 => 100);
         Test10_Expected : constant Track_Array(1..2) := (1 => 50, 2 => 100);
         Test10_Actual : Track_Array(1..2);
      begin
         Results(10) := (
            Name => "Head at Track 0                                    ",
            Initial => 0,
            Request_Count => 2,
            Requests => (1 => 50, 2 => 100, others => 0),
            Expected => (1 => 50, 2 => 100, others => 0),
            Result => Pass,
            Actual => (others => 0)
         );
         Get_SSTF_Schedule(0, Test10_Requests, Test10_Actual);
         Results(10).Actual(1..2) := Test10_Actual(1..2);
         
         if Test10_Actual(1) /= Test10_Expected(1) or Test10_Actual(2) /= Test10_Expected(2) then
            Results(10).Result := Fail;
         end if;
      end;

      -- Remaining test cases are placeholders
      for I in 11..Max_Test_Cases loop
         Results(I) := (
            Name => "Unused Test Case                                    ",
            Initial => 0,
            Request_Count => 1,
            Requests => (others => 0),
            Expected => (others => 0),
            Result => Pass,
            Actual => (others => 0)
         );
      end loop;

   end Run_All_Tests;

   procedure Print_Results (Results : in Test_Case_Array) is
   begin
      Ada.Text_IO.Put_Line("=================================================");
      Ada.Text_IO.Put_Line("SSTF Algorithm Test Results");
      Ada.Text_IO.Put_Line("=================================================");
      Ada.Text_IO.New_Line;
      
      for I in Results'Range loop
         case Results(I).Result is
            when Pass =>
               Ada.Text_IO.Put_Line("[PASS] " & Results(I).Name);
            when Fail =>
               Ada.Text_IO.Put_Line("[FAIL] " & Results(I).Name);
               Ada.Text_IO.Put_Line("       Initial: " & Track_Index'Image(Results(I).Initial));
               Ada.Text_IO.Put("       Requests: ");
               for J in 1..Results(I).Request_Count loop
                  Ada.Text_IO.Put(Track_Index'Image(Results(I).Requests(J)) & " ");
               end loop;
               Ada.Text_IO.New_Line;
               Ada.Text_IO.Put("       Expected: ");
               for J in 1..Results(I).Request_Count loop
                  Ada.Text_IO.Put(Track_Index'Image(Results(I).Expected(J)) & " ");
               end loop;
               Ada.Text_IO.New_Line;
               Ada.Text_IO.Put("       Actual:   ");
               for J in 1..Results(I).Request_Count loop
                  Ada.Text_IO.Put(Track_Index'Image(Results(I).Actual(J)) & " ");
               end loop;
               Ada.Text_IO.New_Line;
            when Error =>
               Ada.Text_IO.Put_Line("[ERROR] " & Results(I).Name);
         end case;
      end loop;
      
      Ada.Text_IO.New_Line;
      Ada.Text_IO.Put_Line("=================================================");
      
      if All_Passed(Results) then
         Ada.Text_IO.Put_Line("ALL TESTS PASSED!");
      else
         Ada.Text_IO.Put_Line("SOME TESTS FAILED!");
      end if;
      
      Ada.Text_IO.Put_Line("=================================================");
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

end SSTF_Tests;
