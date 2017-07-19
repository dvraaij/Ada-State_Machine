package body FSM_Lamp.Test is

   ---------
   -- Run --
   ---------

   procedure Run is

      use FSM_Lamp;

   begin

      Lamp.Process_Event (Event_Data'(Event => Turn_On         ));
      Lamp.Process_Event (Event_Data'(Event => Brightness_Up   ));
      Lamp.Process_Event (Event_Data'(Event => Brightness_Up   ));
      Lamp.Process_Event (Event_Data'(Event => Brightness_Down ));
      Lamp.Process_Event (Event_Data'(Event => Turn_Off        ));

   end Run;

end FSM_Lamp.Test;
