with Ada.Text_IO;   use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

with FSM_Lamp.Test;
with FSM_Player.Test;
with FSM_Stop_Watch.Test;

procedure Main is
begin

   --  FSM_Lamp.Test.Run;
   --  FSM_Player.Test.Run;
   FSM_Stop_Watch.Test.Run;

end Main;
