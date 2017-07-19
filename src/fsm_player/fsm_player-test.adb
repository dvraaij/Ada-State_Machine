with Ada.Text_IO; use Ada.Text_IO;

package body FSM_Player.Test is

   ---------
   -- Run --
   ---------

   procedure Run is

      use FSM_Player;

      procedure Put_State is
      begin
         Put_Line ("--------------------------------> "
                   & Player.Current_State'Image);
      end Put_State;

   begin

      --Put_Line ("Start FSM");
      --Player.Start;

      --  Open drawer, insert CD and close it again
      Player.Process_Event (Event_Data'(Event => Open_Close )); Put_State;
      Player.Process_Event (Event_Data'(Event => Open_Close )); Put_State;

      --  The player detected a CD
      Player.Process_Event
        (Event_Data'
           (Event  => Cd_Detected,
            Artist => "Late Night Alumni   ",
            Title  => "Eclipse             ",
            Year   => 2005                 ));
      Put_State;

      --  Hit play
      Player.Process_Event (Event_Data'(Event => Play      )); Put_State;

      --  Change song
      Player.Process_Event (Event_Data'(Event => Next_Song )); Put_State;
      Player.Process_Event (Event_Data'(Event => Next_Song )); Put_State;
      Player.Process_Event (Event_Data'(Event => Prev_Song )); Put_State;

      -- Hit pause twice
      Player.Process_Event (Event_Data'(Event => Pause     )); Put_State;
      Player.Process_Event (Event_Data'(Event => End_Pause )); Put_State;

      -- Hit pause again and stop
      Player.Process_Event (Event_Data'(Event => Pause     )); Put_State;
      Player.Process_Event (Event_Data'(Event => Stop      )); Put_State;

      -- Hit stop again and then restart playing
      Player.Process_Event (Event_Data'(Event => Stop      )); Put_State;
      Player.Process_Event (Event_Data'(Event => Play      )); Put_State;

      --Put_Line ("Stop FSM");
      --Player.Stop;

      --Put_Line ("Restart FSM");
      --Player.Start;

   end Run;

end FSM_Player.Test;
