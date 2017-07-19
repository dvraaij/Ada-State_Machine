generic
   type Event_Enum is (<>);
   type Event_Data (Event : Event_Enum) is private;
package Generic_FSM is

   FSM_Error : exception;

   ---------------------------
   -- Definition of a state --
   ---------------------------

   type State is tagged null record;
   type State_Access is access all State'Class;

   procedure On_Enter (This : State) is null;
   procedure On_Exit  (This : State) is null;

   procedure Initialize (This : in out State) is null;

   procedure Process_Event (This : in out State; E : Event_Data) is null;

   generic
      type State_Enum is (<>);
   package Machine is

      -----------------------------
      -- Definition of a machine --
      -----------------------------

      type State_Map is
        array (State_Enum) of State_Access;

      type Action_Fcn is access procedure (E : Event_Data);
      type Guard_Fcn  is access function  (E : Event_Data) return Boolean;

      type Transition is
         record
            From   : State_Enum;
            Event  : Event_Enum;
            To     : State_Enum;
            Action : Action_Fcn;
         end record;

      type Transition_Map is
        array (Positive range <>) of Transition;

      type Machine (Transition_Count : Natural) is new State with
         record
            Current_State : State_Enum;
            States        : State_Map;
            Transitions   : Transition_Map (1 .. Transition_Count);
         end record;

      overriding
      procedure Initialize (This : in out Machine);

      overriding
      procedure Process_Event (This : in out Machine; E : Event_Data);

   end Machine;

end Generic_FSM;
