package body Generic_FSM is

   -------------
   -- Machine --
   -------------

   package body Machine is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize (This : in out Machine) is
      begin

         --  Propagate the event (no effect if state is not a machine itself)
         This.States (This.Current_State).Initialize;

         --  Set initial state
         -- This.Current_State := This.Initial_State;

         -- This.States (This.Current_State).On_Enter;

      end Initialize;

      -------------------
      -- Process Event --
      -------------------

      procedure Process_Event (This : in out Machine; E : Event_Data) is
      begin

         --  Propagate the event (no effect if state is not a machine itself)
         This.States (This.Current_State).Process_Event (E);

         --  Apply event on the state of the current machine
         for Idx in This.Transitions'Range loop

            --  Change state of current machine on transition match
            if
              This.Transitions (Idx).From  = This.Current_State and then
              This.Transitions (Idx).Event = E.Event
            then

               This.States (This.Current_State).On_Exit;

               if This.Transitions (Idx).Action /= null then
                  This.Transitions (Idx).Action.all (E);
               end if;

               This.Current_State := This.Transitions (Idx).To;

               This.States (This.Current_State).On_Enter;

               return;

            end if;

         end loop;

      end Process_Event;

   end Machine;

end Generic_FSM;
