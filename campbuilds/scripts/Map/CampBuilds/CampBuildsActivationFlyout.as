package Map.CampBuilds
{
   import Shared.AS3.BSScrollingList;
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.UIDataFromClient;
   import Shared.AS3.Events.CustomEvent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol80")]
   public class CampBuildsActivationFlyout extends BSUIComponent
   {
      
      public static const BACKGROUND_PADDING:Number = 6;
      
      public static const ELEMENT_SPACING:Number = 6;
      
      public var Internal_mc:MovieClip;
      
      public var List_mc:BSScrollingList;
      
      public var MainBG_mc:MovieClip;
      
      public var HeaderBG_mc:MovieClip;
      
      public var MainBGCap_mc:MovieClip;
      
      public var Header_mc:MovieClip;
      
      public var Subheader_mc:MovieClip;
      
      public var CampStatus_mc:MovieClip;
      
      public var Details_mc:MovieClip;
      
      public var SetIconFlyout_mc:SetIconFlyout;
      
      private var m_Header:String;
      
      private var m_Subheader:String;
      
      private var m_TargetType:String;
      
      private var m_IsActive:Boolean;
      
      private var m_IsPlaced:Boolean = true;
      
      private var m_IsHiding:Boolean = false;
      
      private var m_SlotID:uint;
      
      private var m_SelectedCampEntry:Object;
      
      private var m_UseMapPOIOptions:Boolean = false;
      
      private var m_Tooltip:String;
      
      private var m_RetainSelection:Boolean = false;
      
      private var m_Status:String;
      
      public function CampBuildsActivationFlyout()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10,17,this.frame18,18,this.frame19);
         this.List_mc = this.Internal_mc.List_mc;
         this.MainBG_mc = this.Internal_mc.MainBG_mc;
         this.HeaderBG_mc = this.Internal_mc.HeaderBG_mc;
         this.MainBGCap_mc = this.Internal_mc.MainBGCap_mc;
         this.Header_mc = this.Internal_mc.Header_mc;
         this.Subheader_mc = this.Internal_mc.Subheader_mc;
         this.Details_mc = this.Internal_mc.Details_mc;
         this.CampStatus_mc = this.Internal_mc.CampStatus_mc;
         this.List_mc.listEntryClass_Inspectable = CampBuildsShared.LINKAGE_CAMP_BUILDS_ACTIVATION_LIST_ENTRY;
         this.List_mc.numListItems_Inspectable = 10;
         TextFieldEx.setTextAutoSize(this.Header_mc.Header_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.Subheader_mc.Subheader_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.Details_mc.InfoText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.MainBG_mc.mouseChildren = false;
         this.HeaderBG_mc.mouseChildren = false;
         this.MainBGCap_mc.mouseChildren = false;
         this.Header_mc.mouseChildren = false;
         this.Subheader_mc.mouseChildren = false;
         this.List_mc.addEventListener(BSScrollingList.ITEM_PRESS,this.onActivationSelect);
         this.List_mc.addEventListener(BSScrollingList.SELECTION_CHANGE,this.onSelectionChange);
         this.SetIconFlyout_mc.addEventListener(CampBuildsShared.EVENT_ICON_FLYOUT_SHOW,this.onIconFlyoutShow);
         this.SetIconFlyout_mc.addEventListener(CampBuildsShared.EVENT_ICON_FLYOUT_HIDE,this.onIconFlyoutClose);
      }
      
      public function get isActive() : Boolean
      {
         return this.m_IsActive;
      }
      
      public function get isHiding() : Boolean
      {
         return this.m_IsHiding;
      }
      
      public function get slotId() : uint
      {
         return this.m_SlotID;
      }
      
      public function get isPlaced() : Boolean
      {
         return this.m_IsPlaced;
      }
      
      public function set listData(param1:Array) : *
      {
         this.List_mc.entryList = param1;
         SetIsDirty();
      }
      
      public function set selectedCamp(param1:Object) : void
      {
         this.m_SelectedCampEntry = param1;
         SetIsDirty();
      }
      
      public function set useMapPOIOptions(param1:Boolean) : void
      {
         this.m_UseMapPOIOptions = param1;
         SetIsDirty();
      }
      
      public function set retainSelection(param1:Boolean) : void
      {
         this.m_RetainSelection = param1;
      }
      
      private function onActivationSelect(param1:Event) : void
      {
         if(this.List_mc.selectedEntry.funcName == CampBuildsShared.CAMP_SLOTS_MAP_VENDING_HISTORY_SHOW_FUNC)
         {
            GlobalFunc.PlayMenuSound(CampBuildsShared.CAMP_SLOTS_FLYOUT_OPEN_SOUND);
            BSUIDataManager.dispatchEvent(new CustomEvent(this.List_mc.selectedEntry.funcName,{"bFromMap":true}));
         }
         else if(!this.m_UseMapPOIOptions)
         {
            switch(this.List_mc.selectedEntry.funcName)
            {
               case CampBuildsShared.CAMP_SLOTS_SET_CUSTOM_ICON_FUNC:
                  this.SetIconFlyout_mc.showFlyout(this.m_SlotID,this.m_SelectedCampEntry.customIcon);
                  break;
               case CampBuildsShared.CAMP_SLOTS_SET_PUBLIC_FUNC:
               case CampBuildsShared.CAMP_SLOTS_MAP_TOGGLE_PUBLIC_FUNC:
                  if(this.m_SelectedCampEntry.isPublic)
                  {
                     GlobalFunc.PlayMenuSound(CampBuildsShared.CAMP_SLOTS_PUBLIC_ON_SOUND);
                  }
                  else
                  {
                     GlobalFunc.PlayMenuSound(CampBuildsShared.CAMP_SLOTS_PUBLIC_OFF_SOUND);
                  }
                  BSUIDataManager.dispatchEvent(new CustomEvent(this.List_mc.selectedEntry.funcName,{"slotID":this.m_SelectedCampEntry.slotID}));
                  break;
               case CampBuildsShared.CAMP_SLOTS_MAP_ACTIVATE_FUNC:
               case CampBuildsShared.CAMP_SLOTS_ACTIVATE_FUNC:
                  GlobalFunc.PlayMenuSound(CampBuildsShared.CAMP_SLOTS_ACTIVATE_SOUND);
               default:
                  BSUIDataManager.dispatchEvent(new CustomEvent(this.List_mc.selectedEntry.funcName,{"slotID":this.m_SelectedCampEntry.slotID}));
                  this.hideFlyout();
            }
         }
      }
      
      private function onSelectionChange(param1:Event) : void
      {
         GlobalFunc.PlayMenuSound(CampBuildsShared.CAMP_SLOTS_HIGHLIGHT_SOUND);
      }
      
      public function showFlyout(param1:Object, param2:Boolean = false) : void
      {
         var _loc3_:UIDataFromClient = null;
         if(param1)
         {
            this.m_UseMapPOIOptions = param2;
            this.m_IsActive = true;
            this.m_SlotID = param1.slotID;
            this.m_SelectedCampEntry = param1;
            this.List_mc.disableSelection_Inspectable = false;
            if(this.m_SelectedCampEntry != null)
            {
               this.m_Header = GlobalFunc.GenerateName(this.m_SelectedCampEntry.customName);
               this.m_Subheader = GlobalFunc.GenerateTitle(this.m_SelectedCampEntry.customName);
               if(this.m_SelectedCampEntry.isBlocked)
               {
                  this.m_Status = "$CAMP_SLOTS_STATUS_BLOCKED_FLYOUT";
                  this.m_Tooltip = "$CAMP_SLOTS_TOOLTIP_BLOCKED";
               }
               else if(Boolean(this.m_SelectedCampEntry.isActive) && (this.m_SelectedCampEntry.isPlaced || this.m_UseMapPOIOptions))
               {
                  this.m_Status = "$CAMP_SLOTS_STATUS_ACTIVE_PLACED_FLYOUT";
                  this.m_Tooltip = "$CAMP_SLOTS_TOOLTIP_ACTIVE";
               }
               else if(!this.m_SelectedCampEntry.isPlaced && Boolean(this.m_SelectedCampEntry.isActive))
               {
                  this.m_Status = "$CAMP_SLOTS_STATUS_ACTIVE_UNPLACED_FLYOUT";
                  this.m_Tooltip = "$CAMP_SLOTS_TOOLTIP_UNPLACED";
               }
               else if(Boolean(this.m_SelectedCampEntry.isPlaced) && !this.m_SelectedCampEntry.isActive)
               {
                  this.m_Status = "$CAMP_SLOTS_STATUS_STORED_FLYOUT";
                  this.m_Tooltip = "$CAMP_SLOTS_TOOLTIP_STORED";
               }
               else
               {
                  this.m_Status = "$CAMP_SLOTS_STATUS_UNPLACED_FLYOUT";
                  this.m_Tooltip = "$CAMP_SLOTS_TOOLTIP_STORED";
               }
               if(!this.m_UseMapPOIOptions)
               {
                  _loc3_ = BSUIDataManager.GetDataFromClient(CampBuildsShared.EVENT_CAMP_BUILDS_DATA);
                  this.List_mc.entryList = CampBuildsShared.getCampActivationOptions(this.m_SelectedCampEntry.isActive,this.m_SelectedCampEntry.isPublic,this.m_SelectedCampEntry.canFastTravel,false,_loc3_.data.canCustomizeCAMP,this.m_SelectedCampEntry.canSubmitBestBuild,this.m_SelectedCampEntry.canManageBestBuild);
               }
               this.List_mc.InvalidateData();
            }
            GlobalFunc.PlayMenuSound(CampBuildsShared.CAMP_SLOTS_FLYOUT_OPEN_SOUND);
            SetIsDirty();
         }
      }
      
      public function hideFlyout(param1:Boolean = false) : void
      {
         if(this.m_IsActive && !this.m_IsHiding)
         {
            GlobalFunc.PlayMenuSound(CampBuildsShared.CAMP_SLOTS_FLYOUT_CLOSE_SOUND);
            this.List_mc.disableSelection_Inspectable = true;
            this.m_IsHiding = true;
            stage.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
            SetIsDirty();
         }
      }
      
      override public function redrawUIComponent() : void
      {
         super.redrawUIComponent();
         if(this.m_IsHiding)
         {
            this.m_IsHiding = false;
            this.m_IsActive = false;
            if(this.m_UseMapPOIOptions)
            {
               gotoAndStop("off");
            }
            else
            {
               gotoAndPlay("rollOff");
            }
            this.SetIconFlyout_mc.hideFlyout();
            dispatchEvent(new Event(CampBuildsShared.EVENT_FLYOUT_HIDE,true,true));
         }
         else if(this.m_IsActive)
         {
            if(this.m_UseMapPOIOptions && currentLabel != "on")
            {
               gotoAndStop("on");
            }
            else if(!this.m_UseMapPOIOptions && currentLabel != "rollOn" && currentLabel != "on" && currentLabel != "darkened")
            {
               gotoAndPlay("rollOn");
               stage.addEventListener(MouseEvent.CLICK,this.onMouseClick);
            }
            if(this.SetIconFlyout_mc.isActive)
            {
               gotoAndStop("darkened");
               stage.focus = this.SetIconFlyout_mc.List_mc;
            }
            else
            {
               stage.focus = this.List_mc;
            }
            dispatchEvent(new Event(CampBuildsShared.EVENT_FLYOUT_SHOW,true,true));
         }
         if(!this.m_RetainSelection)
         {
            this.List_mc.selectedIndex = 0;
         }
         else
         {
            this.m_RetainSelection = false;
         }
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Array = [];
         if(this.m_Header != null && this.m_Header.length > 0)
         {
            this.Header_mc.visible = true;
            this.Header_mc.y = _loc3_;
            this.Header_mc.Header_tf.text = this.m_Header;
            _loc3_ += this.Header_mc.height;
         }
         else
         {
            this.Header_mc.visible = false;
         }
         if(this.m_Subheader != null && this.m_Subheader.length > 0)
         {
            this.Subheader_mc.visible = true;
            this.Subheader_mc.Subheader_tf.text = this.m_Subheader;
            this.Subheader_mc.y = _loc3_;
            _loc3_ += this.Subheader_mc.height + ELEMENT_SPACING;
         }
         else
         {
            this.Subheader_mc.visible = false;
         }
         if(Boolean(this.m_Status) && this.m_Status != "")
         {
            this.CampStatus_mc.visible = true;
            this.CampStatus_mc.CampStatus_tf.text = this.m_Status;
            this.CampStatus_mc.y = _loc3_;
            _loc3_ += this.CampStatus_mc.height + ELEMENT_SPACING;
         }
         else
         {
            this.CampStatus_mc.visible = false;
         }
         if(this.Header_mc.visible || this.Subheader_mc.visible)
         {
            this.HeaderBG_mc.visible = true;
            this.HeaderBG_mc.height = _loc3_;
            _loc4_.push(this.HeaderBG_mc);
         }
         else
         {
            this.HeaderBG_mc.visible = false;
            _loc2_ += BACKGROUND_PADDING;
         }
         _loc4_.push(this.List_mc);
         this.Details_mc.InfoText_tf.text = this.m_Tooltip;
         _loc4_.push(this.Details_mc);
         _loc2_ += GlobalFunc.arrangeItems(_loc4_,true,GlobalFunc.ALIGN_LEFT,ELEMENT_SPACING,false) - this.HeaderBG_mc.height;
         _loc2_ += BACKGROUND_PADDING;
         this.MainBG_mc.height = _loc2_;
         this.MainBG_mc.y = this.HeaderBG_mc.y + this.HeaderBG_mc.height;
         this.MainBGCap_mc.y = this.MainBG_mc.y + this.MainBG_mc.height;
      }
      
      public function ProcessUserEvent(param1:String, param2:Boolean) : Boolean
      {
         var _loc3_:Boolean = false;
         if(!param2 && this.m_IsActive && !this.m_IsHiding)
         {
            switch(param1)
            {
               case "Up":
                  _loc3_ = true;
                  break;
               case "Down":
                  _loc3_ = true;
                  break;
               case "Cancel":
                  if(this.SetIconFlyout_mc.isActive)
                  {
                     this.SetIconFlyout_mc.hideFlyout();
                  }
                  else
                  {
                     this.hideFlyout();
                  }
                  _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      private function onIconFlyoutShow() : void
      {
         if(this.m_IsActive && !this.m_IsHiding)
         {
            gotoAndStop("darkened");
            this.List_mc.disableSelection_Inspectable = true;
         }
      }
      
      private function onIconFlyoutClose(param1:Event) : void
      {
         if(this.m_IsActive && !this.m_IsHiding)
         {
            gotoAndStop("on");
            this.List_mc.disableSelection_Inspectable = false;
            stage.focus = this.List_mc;
         }
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         if(this.m_IsActive && !this.m_IsHiding)
         {
            if(!this.SetIconFlyout_mc.isActive && !this.hitTestPoint(stage.mouseX,stage.mouseY))
            {
               this.hideFlyout();
            }
            else if(this.SetIconFlyout_mc.isActive && !this.SetIconFlyout_mc.hitTestPoint(stage.mouseX,stage.mouseY))
            {
               this.SetIconFlyout_mc.hideFlyout();
            }
         }
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
      
      internal function frame19() : *
      {
         stop();
      }
   }
}

