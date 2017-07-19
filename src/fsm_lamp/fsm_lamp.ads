with Generic_FSM;

package FSM_Lamp is

   ------------
   -- States --
   ------------   
   
    type State_Enum_Switch is 
     (On, Off);
   
   type State_Enum_Brightness is 
     (Low, Medium, High);  
   
   ------------
   -- Events --
   ------------   
   
   type Event_Enum is 
     (Turn_On, Turn_Off, Brightness_Up, Brightness_Down);  
   
   type Event_Data (Event : Event_Enum) is null record;   
   
   ------------------
   -- FSM packages --
   ------------------
   
   package FSM is 
     new Generic_FSM (Event_Enum => Event_Enum,
                      Event_Data => Event_Data);
   
   package FSM_Switch is 
     new FSM.Machine (State_Enum => State_Enum_Switch);
   
   package FSM_Brightness is 
     new FSM.Machine (State_Enum => State_Enum_Brightness);

   ----------------
   -- Brightness --
   ----------------
   
   S_Brightness_Low    : aliased FSM.State;
   S_Brightness_Medium : aliased FSM.State;
   S_Brightness_High   : aliased FSM.State;   
   
   SM_Brightness : constant FSM_Brightness.State_Map :=
     (Low    => S_Brightness_Low'Access,
      Medium => S_Brightness_Medium'Access,
      High   => S_Brightness_High'Access);
      
   TM_Brightness : constant FSM_Brightness.Transition_Map :=
     (FSM_Brightness.Transition'
        (From   => Low,
         Event  => Brightness_Up,
         To     => Medium,
         Action => null),

      FSM_Brightness.Transition'
        (From   => Medium,
         Event  => Brightness_Up,
         To     => High,
         Action => null),

      FSM_Brightness.Transition'
        (From   => High,
         Event  => Brightness_Down,
         To     => Medium,
         Action => null),

      FSM_Brightness.Transition'
        (From   => Medium,
         Event  => Brightness_Down,
         To     => Low,
         Action => null));
   
   
   -------------------
   -- On/Off Switch --
   -------------------
   
   S_Off : aliased FSM.State;
   S_On  : aliased FSM_Brightness.Machine := 
     FSM_Brightness.Machine'
       (Current_State    => Medium,
        States           => SM_Brightness,
        Transition_Count => TM_Brightness'Length,
        Transitions      => TM_Brightness);  
   
   SM_Switch : constant FSM_Switch.State_Map :=
     (Off => S_Off'Access,
      On  => S_On'Access);

   TM_Switch : constant FSM_Switch.Transition_Map :=
     (FSM_Switch.Transition'
        (From   => Off,
         Event  => Turn_On,
         To     => On,
         Action => null),

      FSM_Switch.Transition'
        (From   => On,
         Event  => Turn_Off,
         To     => Off,
         Action => null));
                     
   ----------
   -- Lamp --
   ----------  
   
   Lamp : aliased FSM_Switch.Machine :=
     FSM_Switch.Machine'
       (Current_State    => Off,
        States           => SM_Switch,
        Transition_Count => TM_Switch'Length,
        Transitions      => TM_Switch);

end FSM_Lamp;
