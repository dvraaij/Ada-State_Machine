with Ada.Text_IO; use Ada.Text_IO;

package body FSM_Stop_Watch is

   ----------------
   -- Start_Stop --
   ----------------

   procedure Start_Stop is
   begin
      Stop_Watch.Process_Event
        (Event_Data'(Event => Start_Stop));
   end Start_Stop;

   -----------
   -- Reset --
   -----------

   procedure Reset is
   begin
      Stop_Watch.Process_Event
        (Event_Data'(Event => Reset));
   end Reset;

   ------------------
   -- Elapsed_Time --
   ------------------

   function Elapsed_Time return Time_Span is
   begin

      return (case S_Active.Current_State is
                 when Running => Elapsed_Time_0 + (Clock - Start_Time),
                 when Stopped => Elapsed_Time_0);

   end Elapsed_Time;

   ------------------------
   -- On_Enter (Running) --
   ------------------------

   procedure On_Enter (This : State_Running) is
   begin

      Start_Time := Clock;

   end On_Enter;

   -----------------------
   -- On_Exit (Running) --
   -----------------------

   procedure On_Exit (This : State_Running) is
   begin

      Elapsed_Time_0 := Elapsed_Time_0 + (Clock - Start_Time);

   end On_Exit;

   ---------------------------
   -- On_Enter (Stop_Watch) --
   ---------------------------

   procedure On_Enter (This : State_Active) is
   begin

      Start_Time     := Clock;
      Elapsed_Time_0 := Time_Span_Zero;

   end On_Enter;

end FSM_Stop_Watch;
