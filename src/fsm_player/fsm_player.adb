with Ada.Text_IO; use Ada.Text_IO;

package body FSM_Player is

   ----------------------
   -- On_Enter (Empty) --
   ----------------------

   procedure On_Enter (This : State_Player_Empty) is
   begin
      Put_Line ("entering  : Empty");
   end On_Enter;

   ---------------------
   -- On_Exit (Empty) --
   ---------------------

   procedure On_Exit (This : State_Player_Empty) is
   begin
      Put_Line ("leaving   : Empty");
   end On_Exit;

   ---------------------
   -- On_Enter (Open) --
   ---------------------

   procedure On_Enter (This : State_Player_Open) is
   begin
      Put_Line ("entering  : Open");
   end On_Enter;

   --------------------
   -- On_Exit (Open) --
   --------------------

   procedure On_Exit (This : State_Player_Open) is
   begin
      Put_Line ("leaving   : Open");
   end On_Exit;

   ------------------------
   -- On_Enter (Stopped) --
   ------------------------

   procedure On_Enter (This : State_Player_Stopped) is
   begin
      Put_Line ("entering  : Stopped");
   end On_Enter;

   -----------------------
   -- On_Exit (Stopped) --
   -----------------------

   procedure On_Exit (This : State_Player_Stopped) is
   begin
      Put_Line ("leaving   : Stopped");
   end On_Exit;

   -----------------------
   -- On_Enter (Paused) --
   -----------------------

   procedure On_Enter (This : State_Player_Paused) is
   begin
      Put_Line ("entering  : Paused");
   end On_Enter;

   ----------------------
   -- On_Exit (Paused) --
   ----------------------

   procedure On_Exit (This : State_Player_Paused) is
   begin
      Put_Line ("leaving   : Paused");
   end On_Exit;

   ------------------------
   -- On_Enter (Playing) --
   ------------------------

   procedure On_Enter (This : State_Player_Playing) is
   begin
      Put_Line ("entering  : Playing");
   end On_Enter;

   -----------------------
   -- On_Exit (Playing) --
   -----------------------

   procedure On_Exit  (This : State_Player_Playing) is
   begin
      Put_Line ("leaving   : Playing");
   end On_Exit;

   -----------------------
   -- On_Enter (Song_1) --
   -----------------------

   procedure On_Enter (This : State_Playing_Song_1) is
   begin
      Put_Line ("starting  : First Song");
   end On_Enter;

   ----------------------
   -- On_Exit (Song_1) --
   ----------------------

   procedure On_Exit (This : State_Playing_Song_1) is
   begin
      Put_Line ("finishing : First Song");
   end On_Exit;

   -----------------------
   -- On_Enter (Song_2) --
   -----------------------

   procedure On_Enter (This : State_Playing_Song_2) is
   begin
      Put_Line ("starting  : Second Song");
   end On_Enter;

   ----------------------
   -- On_Exit (Song_2) --
   ----------------------

   procedure On_Exit  (This : State_Playing_Song_2) is
   begin
      Put_Line ("finishing : Second Song");
   end On_Exit;

   -----------------------
   -- On_Enter (Song_3) --
   -----------------------

   procedure On_Enter (This : State_Playing_Song_3) is
   begin
      Put_Line ("starting  : Third Song");
   end On_Enter;

   ----------------------
   -- On_Exit (Song_1) --
   ----------------------

   procedure On_Exit (This : State_Playing_Song_3) is
   begin
      Put_Line ("finishing : Third Song");
   end On_Exit;

   ---------------------
   -- Start_Next_Song --
   ---------------------

   procedure Start_Next_Song (E : Event_Data) is
   begin
      Put_Line ("action    : Start_Next_Song");
   end Start_Next_Song;

   -------------------------
   -- Start_Previous_Song --
   -------------------------

   procedure Start_Previous_Song (E : Event_Data) is
   begin
      Put_Line ("action    : Start_Previous_Song");
   end Start_Previous_Song;

   --------------------
   -- Start_Playback --
   --------------------

   procedure Start_Playback (E : Event_Data) is
   begin
      Put_Line ("action    : Start_Playback");
   end Start_Playback;

   -----------------
   -- Open_Drawer --
   -----------------

   procedure Open_Drawer (E : Event_Data) is
   begin
      Put_Line ("action    : Open_Drawer");
   end Open_Drawer;

   ------------------
   -- Close_Drawer --
   ------------------

   procedure Close_Drawer (E : Event_Data) is
   begin
      Put_Line ("action    : Close_Drawer");
   end Close_Drawer;

   -------------------
   -- Store_Cd_Info --
   -------------------

   procedure Store_Cd_Info (E : Event_Data) is
   begin

      Put_Line ("action    : Store_Cd_Info");

      if E.Event = Cd_Detected then

         Put_Line ("= artist  : " & E.Artist     );
         Put_Line ("= title   : " & E.Title      );
         Put_Line ("= year    :"  & E.Year'Image );

      end if;

   end Store_Cd_Info;

   -------------------
   -- Stop_Playback --
   -------------------

   procedure Stop_Playback (E : Event_Data) is
   begin
      Put_Line ("action    : Stop_Playback");
   end Stop_Playback;

   -------------------
   -- Pause_Playback--
   -------------------

   procedure Pause_Playback (E : Event_Data) is
   begin
      Put_Line ("action    : Pause_Playback");
   end Pause_Playback;

   ---------------------
   -- Resume_Playback --
   ---------------------

   procedure Resume_Playback (E : Event_Data) is
   begin
      Put_Line ("action    : Resume_Playback");
   end Resume_Playback;

   -------------------
   -- Stop_And_Open --
   -------------------

   procedure Stop_And_Open (E : Event_Data) is
   begin
      Put_Line ("action    : Stop_And_Open");
   end Stop_And_Open;

   -------------------
   -- Stopped_Again --
   -------------------

   procedure Stopped_Again (E : Event_Data) is
   begin
      Put_Line ("action    : Stopped_Again");
   end Stopped_Again;

end FSM_Player;
