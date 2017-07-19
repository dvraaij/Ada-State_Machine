with Generic_FSM;

package FSM_Player is

   ------------
   -- States --
   ------------
   
   type State_Enum_Player is 
     (Empty, Open, Stopped, Paused, Playing);
   
   type State_Enum_Playing is 
     (Song_1, Song_2, Song_3);
  
   ------------
   -- Events --
   ------------
   
   type Event_Enum is 
     (Open_Close,
      Cd_Detected,
      Stop,
      Pause,
      End_Pause,
      Play,
      Next_Song,
      Prev_Song);
 
   type Event_Data (Event : Event_Enum) is 
      record
         case Event is
            when Cd_Detected =>
               Artist : String (1 .. 20);
               Title  : String (1 .. 20);
               Year   : Natural;
            when others =>
               null;
         end case;
      end record;
    
   ------------------
   -- FSM packages --
   ------------------   
   
   package FSM is 
     new Generic_FSM (Event_Enum => Event_Enum, 
                      Event_Data => Event_Data);
   
   package FSM_Player is 
     new FSM.Machine (State_Enum => State_Enum_Player);
   
   package FSM_Playing is 
     new FSM.Machine (State_Enum => State_Enum_Playing);
  
   -------------
   -- Playing --
   -------------
   
   type State_Playing_Song_1 is new FSM.State with null record;
   type State_Playing_Song_2 is new FSM.State with null record;
   type State_Playing_Song_3 is new FSM.State with null record;
   
   overriding procedure On_Enter (This : State_Playing_Song_1);
   overriding procedure On_Exit  (This : State_Playing_Song_1);
   
   overriding procedure On_Enter (This : State_Playing_Song_2);
   overriding procedure On_Exit  (This : State_Playing_Song_2);
   
   overriding procedure On_Enter (This : State_Playing_Song_3);
   overriding procedure On_Exit  (This : State_Playing_Song_3);
      
   S_Playing_Song_1 : aliased State_Playing_Song_1;
   S_Playing_Song_2 : aliased State_Playing_Song_2;
   S_Playing_Song_3 : aliased State_Playing_Song_3;   
    
   SM_Playing : constant FSM_Playing.State_Map :=
     (Song_1 => S_Playing_Song_1'Access,
      Song_2 => S_Playing_Song_2'Access,
      Song_3 => S_Playing_Song_3'Access);
   
   
   procedure Start_Next_Song     (E : Event_Data);
   procedure Start_Previous_Song (E : Event_Data);
   
      
   TM_Playing : constant FSM_Playing.Transition_Map :=
     (FSM_Playing.Transition'
        (From   => Song_1,
         Event  => Next_Song,
         To     => Song_2,
         Action => Start_Next_Song'Access),

      FSM_Playing.Transition'
        (From   => Song_2,
         Event  => Next_Song,
         To     => Song_3,
         Action => Start_Next_Song'Access),

      FSM_Playing.Transition'
        (From   => Song_3,
         Event  => Prev_Song,
         To     => Song_2,
         Action => Start_Previous_Song'Access),

      FSM_Playing.Transition'
        (From   => Song_2,
         Event  => Prev_Song,
         To     => Song_1,
         Action => Start_Previous_Song'Access));   
   
   ------------
   -- Player --
   ------------
   
   type State_Player_Empty   is new FSM.State with null record;
   type State_Player_Open    is new FSM.State with null record;
   type State_Player_Stopped is new FSM.State with null record;
   type State_Player_Paused  is new FSM.State with null record;
   type State_Player_Playing is new FSM_Playing.Machine with null record;
      
   overriding procedure On_Enter (This : State_Player_Empty);
   overriding procedure On_Exit  (This : State_Player_Empty);
   
   overriding procedure On_Enter (This : State_Player_Open);
   overriding procedure On_Exit  (This : State_Player_Open);
   
   overriding procedure On_Enter (This : State_Player_Stopped);
   overriding procedure On_Exit  (This : State_Player_Stopped);
   
   overriding procedure On_Enter (This : State_Player_Paused);
   overriding procedure On_Exit  (This : State_Player_Paused);
   
   overriding procedure On_Enter (This : State_Player_Playing);
   overriding procedure On_Exit  (This : State_Player_Playing);
   
   
   S_Player_Empty   : aliased State_Player_Empty;
   S_Player_Open    : aliased State_Player_Open;
   S_Player_Stopped : aliased State_Player_Stopped;
   S_Player_Paused  : aliased State_Player_Paused;
   S_Player_Playing : aliased State_Player_Playing := 
     State_Player_Playing'
       (Current_State    => Song_1,
        States           => SM_Playing,
        Transition_Count => TM_Playing'Length,
        Transitions      => TM_Playing);
   
   SM_Player : constant FSM_Player.State_Map :=
     (Empty   => S_Player_Empty'Access,
      Open    => S_Player_Open'Access,
      Stopped => S_Player_Stopped'Access,
      Paused  => S_Player_Paused'Access,
      Playing => S_Player_Playing'Access);
   
   
   procedure Start_Playback  (E : Event_Data);
   procedure Open_Drawer     (E : Event_Data);
   procedure Close_Drawer    (E : Event_Data);
   procedure Store_Cd_Info   (E : Event_Data);
   procedure Stop_Playback   (E : Event_Data);
   procedure Pause_Playback  (E : Event_Data);
   procedure Resume_Playback (E : Event_Data);
   procedure Stop_And_Open   (E : Event_Data);
   procedure Stopped_Again   (E : Event_Data);
   
   
   TM_Player : constant FSM_Player.Transition_Map :=
     (FSM_Player.Transition'
        (From   => Empty,
         Event  => Open_Close,
         To     => Open,
         Action => Open_Drawer'Access),
      
      FSM_Player.Transition'
        (From   => Empty,
         Event  => Cd_Detected,
         To     => Stopped,
         Action => Store_Cd_Info'Access),
      
      FSM_Player.Transition'
        (From   => Open,
         Event  => Open_Close,
         To     => Empty,
         Action => Close_Drawer'Access),
      
      FSM_Player.Transition'
        (From   => Stopped,
         Event  => Open_Close,
         To     => Open,
         Action => Open_Drawer'Access),
      
      FSM_Player.Transition'
        (From   => Stopped,
         Event  => Play,
         To     => Playing,
         Action => Start_Playback'Access),
      
      FSM_Player.Transition'
        (From   => Stopped,
         Event  => Stop,
         To     => Stopped,
         Action => Stopped_Again'Access),
      
      FSM_Player.Transition'
        (From   => Paused,
         Event  => Open_Close,
         To     => Open,
         Action => Stop_And_Open'Access),
      
      FSM_Player.Transition'
        (From   => Paused,
         Event  => End_Pause,
         To     => Playing,
         Action => Resume_Playback'Access),
      
      FSM_Player.Transition'
        (From   => Paused,
         Event  => Stop,
         To     => Stopped,
         Action => Stop_Playback'Access),
      
      FSM_Player.Transition'
        (From   => Playing,
         Event  => Open_Close,
         To     => Open,
         Action => Stop_And_Open'Access),
      
      FSM_Player.Transition'
        (From   => Playing,
         Event  => Pause,
         To     => Paused,
         Action => Pause_Playback'Access),
      
      FSM_Player.Transition'
        (From   => Playing,
         Event  => Stop,
         To     => Stopped,
         Action => Stop_Playback'Access));
      
   Player : aliased FSM_Player.Machine := 
     FSM_Player.Machine'
       (Current_State    => Empty,
        States           => SM_Player,
        Transition_Count => TM_Player'Length,
        Transitions      => TM_Player);   
   
end FSM_Player;
