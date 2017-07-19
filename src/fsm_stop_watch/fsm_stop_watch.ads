with Ada.Real_Time; use Ada.Real_Time;

with Generic_FSM;

package FSM_Stop_Watch is

   procedure Start_Stop;

   procedure Reset;

   function Elapsed_Time return Time_Span;

private

   Start_Time     : Time      := Clock;
   Elapsed_Time_0 : Time_Span := Time_Span_Zero;

   ------------
   -- States --
   ------------

   type State_Enum_Stop_Watch is (Active);
   type State_Enum_Timer      is (Running, Stopped);

   ------------
   -- Events --
   ------------

   type Event_Enum is (Start_Stop, Reset);

   type Event_Data (Event : Event_Enum) is null record;

   ------------------
   -- FSM packages --
   ------------------

   package FSM is
     new Generic_FSM (Event_Enum => Event_Enum,
                      Event_Data => Event_Data);

   package FSM_Stop_Watch is
     new FSM.Machine (State_Enum => State_Enum_Stop_Watch);

   package FSM_Timer is
     new FSM.Machine (State_Enum => State_Enum_Timer);

   -----------
   -- Timer --
   -----------

   type State_Running is new FSM.State with null record;
   type State_Stopped is new FSM.State with null record;

   procedure On_Enter (This : State_Running);
   procedure On_Exit  (This : State_Running);

   S_Running : aliased State_Running;
   S_Stopped : aliased State_Stopped;

   State_Map_Timer : constant FSM_Timer.State_Map :=
     (Running => S_Running'Access,
      Stopped => S_Stopped'Access);

   Transition_Map_Timer : aliased FSM_Timer.Transition_Map :=
     (1 => FSM_Timer.Transition'
        (From   => Stopped,
         Event  => Start_Stop,
         To     => Running,
         Action => null),

      2 => FSM_Timer.Transition'
        (From   => Running,
         Event  => Start_Stop,
         To     => Stopped,
         Action => null));

   ----------------
   -- Stop_Watch --
   ----------------

   type State_Active is new FSM_Timer.Machine with null record;

   overriding procedure On_Enter (This : State_Active);

   S_Active : aliased State_Active :=
     State_Active'
       (Current_State    => Stopped,
        States           => State_Map_Timer,
        Transition_Count => Transition_Map_Timer'Length,
        Transitions      => Transition_Map_Timer);

   State_Map_Stop_Watch : constant FSM_Stop_Watch.State_Map :=
     (Active => S_Active'Access);

   Transition_Map_Stop_Watch : aliased FSM_Stop_Watch.Transition_Map :=
     (1 => FSM_Stop_Watch.Transition'
        (From   => Active,
         Event  => Reset,
         To     => Active,
         Action => null));

   Stop_Watch : aliased FSM_Stop_Watch.Machine :=
     FSM_Stop_Watch.Machine'
       (Current_State    => Active,
        States           => State_Map_Stop_Watch,
        Transition_Count => Transition_Map_Stop_Watch'Length,
        Transitions      => Transition_Map_Stop_Watch);

end FSM_Stop_Watch;
