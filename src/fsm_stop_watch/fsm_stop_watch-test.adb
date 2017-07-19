with Ada.Text_IO; use Ada.Text_IO;

package body FSM_Stop_Watch.Test is

   ---------
   -- Run --
   ---------

   procedure Run is

      use FSM_Stop_Watch;

      procedure Put_Elapsed_Time is
      begin
         Put_Line ("Elapsed time : " &
                     Duration'Image (To_Duration (Elapsed_Time)));
      end Put_Elapsed_Time;

      procedure Wait is
      begin
         delay To_Duration (Milliseconds (100));
      end Wait;

   begin

      Put_Elapsed_Time;  --   0
      Start_Stop;
      Wait;
      Put_Elapsed_Time;  -- 100
      Wait;
      Put_Elapsed_Time;  -- 200
      Start_Stop;
      Wait;
      Start_Stop;
      Wait;
      Put_Elapsed_Time;  -- 300
      Start_Stop;
      Wait;
      Put_Elapsed_Time;  -- 300
      Reset;
      Put_Elapsed_Time;  --   0
      Wait;
      Start_Stop;
      Wait;
      Put_Elapsed_Time;  -- 100
      Reset;
      Put_Elapsed_Time;  --   0
      Start_Stop;
      Put_Elapsed_Time;  --   0

   end Run;

end FSM_Stop_Watch.Test;
