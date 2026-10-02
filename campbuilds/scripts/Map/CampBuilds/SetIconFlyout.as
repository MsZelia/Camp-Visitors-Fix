package Map.CampBuilds
{
   import Shared.AS3.BCGridList;
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Events.CustomEvent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol68")]
   public class SetIconFlyout extends BSUIComponent
   {
      
      public var Internal_mc:MovieClip;
      
      public var List_mc:BCGridList;
      
      public var HeaderBG_mc:MovieClip;
      
      public var MainBG_mc:MovieClip;
      
      public var MainBGCap_mc:MovieClip;
      
      public var Header_mc:MovieClip;
      
      private var m_SlotID:uint;
      
      private var m_IsActive:Boolean = false;
      
      public function SetIconFlyout()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10,17,this.frame18);
         this.List_mc = this.Internal_mc.List_mc;
         this.HeaderBG_mc = this.Internal_mc.HeaderBG_mc;
         this.MainBG_mc = this.Internal_mc.MainBG_mc;
         this.MainBGCap_mc = this.Internal_mc.MainBGCap_mc;
         this.Header_mc = this.Internal_mc.Header_mc;
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function get isActive() : Boolean
      {
         return this.m_IsActive;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this.List_mc.listItemClassName = CampBuildsShared.LINKAGE_SET_ICON_FLYOUT_LIST_ENTRY;
         this.List_mc.maxRows = 8;
         this.List_mc.maxCols = 6;
         this.List_mc.scrollVertical = true;
         this.List_mc.addEventListener(BCGridList.ITEM_PRESS,this.onActivationSelect);
         this.List_mc.addEventListener(BCGridList.SELECTION_CHANGE,this.onSelectionChange);
         this.List_mc.entryData = CampBuildsShared.buildSetIconListData();
         this.List_mc.selectedIndex = 0;
         TextFieldEx.setTextAutoSize(this.Header_mc.Header_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      override public function redrawUIComponent() : void
      {
         super.redrawUIComponent();
      }
      
      public function showFlyout(param1:uint, param2:uint) : void
      {
         this.m_SlotID = param1;
         this.List_mc.selectedIndex = 0;
         GlobalFunc.PlayMenuSound(CampBuildsShared.CAMP_SLOTS_FLYOUT_OPEN_SOUND);
         this.m_IsActive = true;
         if(currentLabel != "on" && currentLabel != "rollOn")
         {
            gotoAndPlay("rollOn");
         }
         stage.focus = this.List_mc;
         dispatchEvent(new Event(CampBuildsShared.EVENT_ICON_FLYOUT_SHOW));
      }
      
      public function hideFlyout() : void
      {
         GlobalFunc.PlayMenuSound(CampBuildsShared.CAMP_SLOTS_FLYOUT_CLOSE_SOUND);
         this.m_IsActive = false;
         if(currentLabel != "off" && currentLabel != "rollOff")
         {
            gotoAndPlay("rollOff");
         }
         dispatchEvent(new Event(CampBuildsShared.EVENT_ICON_FLYOUT_HIDE));
      }
      
      private function onActivationSelect(param1:Event) : void
      {
         GlobalFunc.PlayMenuSound(CampBuildsShared.CAMP_SLOTS_ICON_SELECT_SOUND);
         BSUIDataManager.dispatchEvent(new CustomEvent(CampBuildsShared.EVENT_CAMP_SLOTS_CHANGE_ICON,{
            "slotID":this.m_SlotID,
            "customIcon":this.List_mc.selectedIndex
         }));
         this.hideFlyout();
      }
      
      private function onSelectionChange(param1:Event) : void
      {
         GlobalFunc.PlayMenuSound(CampBuildsShared.CAMP_SLOTS_HIGHLIGHT_SOUND);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame10() : *
      {
         stop();
      }
      
      internal function frame18() : *
      {
         stop();
      }
   }
}

