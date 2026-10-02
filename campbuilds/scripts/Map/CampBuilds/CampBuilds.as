package Map.CampBuilds
{
   import Shared.AS3.BCGridList;
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Data.UIDataFromClient;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol95")]
   public class CampBuilds extends BSUIComponent
   {
      
      private static var UNLOCKABLE_ENTRY:Object = {"isUnlockable":true};
      
      public var Header_mc:MovieClip;
      
      public var HeaderBG_mc:MovieClip;
      
      public var List_mc:BCGridList;
      
      public var BodyBG_mc:MovieClip;
      
      public var NavButton_mc:BSButtonHintBar;
      
      public var CampBuildsActivationFlyout_mc:CampBuildsActivationFlyout;
      
      public var ActiveCampInfoContainer_mc:MovieClip;
      
      public var LikeCount_mc:MovieClip;
      
      public var Subheader_mc:MovieClip;
      
      public var CampStatus_mc:MovieClip;
      
      public var Icon0_mc:ImageFixture;
      
      public var Icon1_mc:ImageFixture;
      
      public var Icon2_mc:ImageFixture;
      
      public var Icon3_mc:ImageFixture;
      
      public var Icon4_mc:ImageFixture;
      
      public var Icon5_mc:ImageFixture;
      
      private const CLEAR_LIKE_COUNT_UPDATE:String = "CampBuilds::ClearLikeUpdates";
      
      private const EXPANDED_MAX_ROWS:uint = 4;
      
      private var m_IsActive:Boolean = false;
      
      private var m_IsPlaced:Boolean = false;
      
      private var m_Disabled:Boolean = false;
      
      private var m_DisableInput:Boolean = false;
      
      private var m_WorldType:uint = 0;
      
      private var m_IsDead:Boolean = false;
      
      private var m_ShouldNavigate:Boolean = false;
      
      private var m_NavigateId:uint = 0;
      
      private var m_CanNavigate:Boolean = true;
      
      private var m_BudgetStored:Number = 0;
      
      private var m_BudgetUsed:Number = 0;
      
      private var m_BudgetTotal:Number = 0;
      
      private var m_CampBuildsRect:Rectangle;
      
      private var m_VisitorIcons:Array;
      
      private var m_SelectedEntry:Object;
      
      private var m_AllowActivation:Boolean = true;
      
      private var m_ExpandButton:BSButtonHintData;
      
      private var m_CollapseButton:BSButtonHintData;
      
      public function CampBuilds()
      {
         this.m_ExpandButton = new BSButtonHintData("","Down","_DPad_Down","_DPad_Down",1,this.onExpand);
         this.m_CollapseButton = new BSButtonHintData("","Left","_DPad_Left","_DPad_Left",1,this.onCollapse);
         super();
         addFrameScript(0,this.frame1,7,this.frame8,14,this.frame15,15,this.frame16);
         this.Icon0_mc = this.ActiveCampInfoContainer_mc.Icon0_mc;
         this.Icon1_mc = this.ActiveCampInfoContainer_mc.Icon1_mc;
         this.Icon2_mc = this.ActiveCampInfoContainer_mc.Icon2_mc;
         this.Icon3_mc = this.ActiveCampInfoContainer_mc.Icon3_mc;
         this.Icon4_mc = this.ActiveCampInfoContainer_mc.Icon4_mc;
         this.Icon5_mc = this.ActiveCampInfoContainer_mc.Icon5_mc;
         this.Subheader_mc = this.ActiveCampInfoContainer_mc.Subheader_mc;
         this.CampStatus_mc = this.ActiveCampInfoContainer_mc.CampStatus_mc;
         this.NavButton_mc = this.Header_mc.NavButton_mc;
         this.NavButton_mc.useBackground = false;
         this.NavButton_mc.SetButtonHintData(new <BSButtonHintData>[this.m_ExpandButton,this.m_CollapseButton]);
         this.m_CollapseButton.ButtonVisible = false;
         this.NavButton_mc.align = GlobalFunc.BUTTON_BAR_ALIGN_LEFT;
         this.List_mc.listItemClassName = CampBuildsShared.LINKAGE_CAMP_BUILDS_ENTRY;
         this.List_mc.maxCols = 1;
         this.List_mc.maxRows = this.EXPANDED_MAX_ROWS;
         this.List_mc.scrollVertical = false;
         this.List_mc.idName = "id";
         this.List_mc.showSelectedItem = true;
         this.List_mc.addEventListener(BCGridList.ITEM_PRESS,this.onCampBuildsListAccept);
         this.List_mc.addEventListener(BCGridList.SELECTION_CHANGE,this.onCampBuildsListSelectionChange);
         this.m_CampBuildsRect = new Rectangle(x,y,this.HeaderBG_mc.width,this.HeaderBG_mc.height + this.BodyBG_mc.height);
         TextFieldEx.setTextAutoSize(this.Subheader_mc.Subheader_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.CampStatus_mc.CampStatus_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.LikeCount_mc.LikeCount_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.LikeCount_mc.visible = false;
         this.initializeIconSizes();
         this.__setTab_HeaderBG_mc_CampBuilds_HeaderBG_mc_0();
      }
      
      public function set budgetStored(param1:Number) : void
      {
         this.m_BudgetStored = param1;
         SetIsDirty();
      }
      
      public function set budgetUsed(param1:Number) : void
      {
         this.m_BudgetUsed = param1;
         SetIsDirty();
      }
      
      public function set budgetTotal(param1:Number) : void
      {
         this.m_BudgetTotal = param1;
         SetIsDirty();
      }
      
      public function get disabled() : Boolean
      {
         return this.m_Disabled;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         if(param1 != this.m_Disabled)
         {
            this.m_Disabled = param1;
            if(this.m_Disabled)
            {
               this.onCollapse();
               this.List_mc.disableInput = true;
            }
            else
            {
               this.updateList();
               this.List_mc.disableInput = this.disableInput;
            }
            visible = !this.m_Disabled;
         }
      }
      
      public function get disableInput() : Boolean
      {
         return this.m_DisableInput;
      }
      
      public function set disableInput(param1:Boolean) : void
      {
         if(param1 != this.m_DisableInput)
         {
            this.m_DisableInput = param1;
            this.List_mc.disableInput = param1;
         }
      }
      
      public function get isActive() : Boolean
      {
         return this.m_IsActive;
      }
      
      public function get isPlaced() : Boolean
      {
         return this.m_IsPlaced;
      }
      
      public function get campBuildsRect() : Rectangle
      {
         return this.m_CampBuildsRect;
      }
      
      public function get allowActivation() : Boolean
      {
         return this.m_AllowActivation;
      }
      
      public function set allowActivation(param1:Boolean) : void
      {
         this.m_AllowActivation = param1;
         SetIsDirty();
      }
      
      private function initializeIconSizes() : void
      {
         this.m_VisitorIcons = [this.Icon0_mc,this.Icon1_mc,this.Icon2_mc,this.Icon3_mc,this.Icon4_mc,this.Icon5_mc];
         this.Icon0_mc.clipWidth = this.Icon0_mc.width * (1 / this.Icon0_mc.scaleX);
         this.Icon0_mc.clipHeight = this.Icon0_mc.height * (1 / this.Icon0_mc.scaleY);
         this.Icon1_mc.clipWidth = this.Icon1_mc.width * (1 / this.Icon1_mc.scaleX);
         this.Icon1_mc.clipHeight = this.Icon1_mc.height * (1 / this.Icon1_mc.scaleY);
         this.Icon2_mc.clipWidth = this.Icon2_mc.width * (1 / this.Icon2_mc.scaleX);
         this.Icon2_mc.clipHeight = this.Icon2_mc.height * (1 / this.Icon2_mc.scaleY);
         this.Icon3_mc.clipWidth = this.Icon3_mc.width * (1 / this.Icon3_mc.scaleX);
         this.Icon3_mc.clipHeight = this.Icon3_mc.height * (1 / this.Icon3_mc.scaleY);
         this.Icon4_mc.clipWidth = this.Icon4_mc.width * (1 / this.Icon4_mc.scaleX);
         this.Icon4_mc.clipHeight = this.Icon4_mc.height * (1 / this.Icon4_mc.scaleY);
         this.Icon5_mc.clipWidth = this.Icon5_mc.width * (1 / this.Icon5_mc.scaleX);
         this.Icon5_mc.clipHeight = this.Icon5_mc.height * (1 / this.Icon5_mc.scaleY);
      }
      
      override public function onAddedToStage() : void
      {
         BSUIDataManager.Subscribe(CampBuildsShared.EVENT_CAMP_BUILDS_DATA,this.onCampBuildsDataUpdate);
         BSUIDataManager.Subscribe("AccountInfoData",this.onAccountInfoUpdate);
         BSUIDataManager.Subscribe("CharacterInfoData",this.onCharacterInfoUpdate);
         BSUIDataManager.Subscribe("MapMenuData",this.onMapMenuDataUpdate);
         TextFieldEx.setTextAutoSize(this.Header_mc.Header_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.Header_mc.NavText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.CampBuildsActivationFlyout_mc.addEventListener(CampBuildsShared.EVENT_FLYOUT_SHOW,this.onFlyoutShow);
         this.CampBuildsActivationFlyout_mc.addEventListener(CampBuildsShared.EVENT_FLYOUT_HIDE,this.onFlyoutHide);
         addEventListener(MouseEvent.CLICK,this.onMouseClick);
      }
      
      override public function redrawUIComponent() : void
      {
         super.redrawUIComponent();
         this.m_ExpandButton.ButtonEnabled = this.m_AllowActivation;
      }
      
      public function setDarkened(param1:Boolean) : void
      {
         if(currentLabel != "off" && currentLabel != "off2")
         {
            if(param1)
            {
               gotoAndStop("darkened");
            }
            else
            {
               gotoAndStop("on");
            }
         }
      }
      
      private function shouldDisable() : Boolean
      {
         return this.m_WorldType == GlobalFunc.WORLD_TYPE_INVALID || this.m_IsDead;
      }
      
      private function onExpand() : void
      {
         if(!this.m_IsActive && !this.disabled && this.m_AllowActivation)
         {
            this.m_IsActive = true;
            this.List_mc.disableInput = false;
            this.List_mc.selectedIndex = -1;
            stage.focus = this.List_mc;
            GlobalFunc.PlayMenuSound(CampBuildsShared.CAMP_SLOTS_FLYOUT_OPEN_SOUND);
            if(this.CampBuildsActivationFlyout_mc.isActive)
            {
               gotoAndStop("darkened");
            }
            else
            {
               gotoAndPlay("expand");
            }
            dispatchEvent(new Event(CampBuildsShared.EVENT_ON_EXPAND));
            addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      private function onCollapse() : void
      {
         if(this.m_IsActive && (currentLabel == "on" || currentLabel == "darkened"))
         {
            this.m_IsActive = false;
            this.CampBuildsActivationFlyout_mc.hideFlyout();
            GlobalFunc.PlayMenuSound(CampBuildsShared.CAMP_SLOTS_FLYOUT_CLOSE_SOUND);
            gotoAndPlay("collapse");
            dispatchEvent(new Event(CampBuildsShared.EVENT_ON_COLLAPSE,true,true));
            addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            this.LikeCount_mc.visible = false;
            BSUIDataManager.dispatchEvent(new Event(this.CLEAR_LIKE_COUNT_UPDATE));
         }
      }
      
      private function updateList() : void
      {
         var _loc1_:UIDataFromClient = null;
         var _loc2_:Array = null;
         if(!this.disabled)
         {
            _loc1_ = BSUIDataManager.GetDataFromClient(CampBuildsShared.EVENT_CAMP_BUILDS_DATA);
            if(Boolean(_loc1_.data) && Boolean(_loc1_.data.campSlotsArray))
            {
               _loc2_ = _loc1_.data.campSlotsArray.concat();
               if(_loc1_.data.showUnlockableSlot)
               {
                  _loc2_.push(UNLOCKABLE_ENTRY);
               }
               this.List_mc.entryData = _loc2_;
            }
            if(this.List_mc.entryData.length > 0)
            {
               if(this.List_mc.selectedIndex == -1)
               {
                  this.List_mc.selectedIndex = 0;
               }
            }
         }
      }
      
      public function ProcessUserEvent(param1:String, param2:Boolean) : Boolean
      {
         var _loc3_:Boolean = false;
         if(!param2 && !this.disabled && !this.disableInput)
         {
            if(!this.m_IsActive && this.m_AllowActivation)
            {
               switch(param1)
               {
                  case "Down":
                     this.onExpand();
                     _loc3_ = true;
               }
            }
            else if(this.CampBuildsActivationFlyout_mc.isActive)
            {
               _loc3_ = this.CampBuildsActivationFlyout_mc.ProcessUserEvent(param1,param2);
            }
            else if(!_loc3_)
            {
               switch(param1)
               {
                  case "Left":
                     this.onCollapse();
                     _loc3_ = true;
                     break;
                  case "Down":
                     _loc3_ = true;
                     break;
                  case "Left":
                     _loc3_ = true;
                     break;
                  case "Cancel":
                     this.onCollapse();
                     _loc3_ = true;
               }
            }
         }
         return _loc3_;
      }
      
      private function onCampBuildsDataUpdate(param1:FromClientDataEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:* = undefined;
         var _loc4_:Object = null;
         if(param1.data != null && param1.data.campSlotsArray != null)
         {
            this.Subheader_mc.Subheader_tf.text = "";
            this.CampStatus_mc.CampStatus_tf.text = "";
            _loc2_ = 0;
            _loc3_ = 0;
            while(_loc3_ < param1.data.campSlotsArray.length)
            {
               _loc4_ = param1.data.campSlotsArray[_loc3_];
               if(_loc4_.isActive)
               {
                  this.Subheader_mc.Subheader_tf.text = GlobalFunc.LocalizeFormattedString(GlobalFunc.GenerateNameAndTitle(_loc4_.customName));
                  if(_loc4_.isBlocked)
                  {
                     this.CampStatus_mc.CampStatus_tf.text = GlobalFunc.LocalizeFormattedString("$CAMP_SLOTS_STATUS_BLOCKED");
                  }
                  else if(!_loc4_.isPlaced)
                  {
                     this.CampStatus_mc.CampStatus_tf.text = GlobalFunc.LocalizeFormattedString("$CAMP_SLOTS_STATUS_ACTIVE_UNPLACED");
                  }
                  else
                  {
                     this.CampStatus_mc.CampStatus_tf.text = GlobalFunc.LocalizeFormattedString("$CAMP_SLOTS_STATUS_ACTIVE_PLACED");
                  }
                  this.setVisitorIcons(_loc4_.playersInCamp);
               }
               _loc2_ = Boolean(_loc4_.likeCountUpdate) && _loc4_.likeCountUpdate > _loc2_ ? uint(_loc4_.likeCountUpdate) : _loc2_;
               _loc3_++;
            }
            this.LikeCount_mc.LikeCount_tf.text = _loc2_;
            this.LikeCount_mc.visible = _loc2_ > 0;
         }
         this.updateList();
         if(this.CampBuildsActivationFlyout_mc.isActive && Boolean(this.List_mc.selectedEntry))
         {
            this.CampBuildsActivationFlyout_mc.retainSelection = true;
            this.CampBuildsActivationFlyout_mc.showFlyout(this.List_mc.selectedEntry);
         }
      }
      
      private function onAccountInfoUpdate(param1:FromClientDataEvent) : void
      {
         if(param1.data)
         {
            this.m_WorldType = param1.data.worldType;
            this.disabled = this.shouldDisable();
         }
      }
      
      private function onCharacterInfoUpdate(param1:FromClientDataEvent) : void
      {
         if(param1.data)
         {
            this.m_IsDead = param1.data.isDead;
            this.disabled = this.shouldDisable();
         }
      }
      
      private function onMapMenuDataUpdate(param1:FromClientDataEvent) : void
      {
         var i:int;
         var players:Array;
         var myCamp:Object;
         var debug:Boolean = false;
         try
         {
            i = 0;
            players = [];
            myCamp = null;
            if(param1 && param1.data && param1.data.MarkerData)
            {
               while(i < param1.data.MarkerData.length)
               {
                  marker = param1.data.MarkerData[i];
                  if(marker.playerLevel > 0)
                  {
                     players.push({
                        "x":marker.x,
                        "y":marker.y,
                        "szAvatarID":marker.avatarID
                     });
                  }
                  else if(marker.isLocalPlayersCamp)
                  {
                     if(marker.campSlots.isActive)
                     {
                        myCamp = {
                           "x":marker.x,
                           "y":marker.y
                        };
                     }
                  }
                  i++;
               }
               if(myCamp != null)
               {
                  players = players.filter(function(p:*):Boolean
                  {
                     return Math.sqrt(Math.pow(myCamp.x - p.x,2) + Math.pow(myCamp.y - p.y,2)) <= 0.005;
                  });
                  if(debug)
                  {
                     GlobalFunc.ShowHUDMessage("Visitors: " + players.join(", "));
                  }
                  setVisitorIcons(players);
               }
               else if(debug)
               {
                  GlobalFunc.ShowHUDMessage("Active camp not found!");
               }
            }
         }
         catch(e:*)
         {
            if(debug)
            {
               GlobalFunc.ShowHUDMessage("Error onMapMenuDataUpdate: " + e);
            }
         }
      }
      
      public function onCampBuildsListAccept(param1:Event) : void
      {
         if(this.List_mc.selectedEntry.isUnlockable)
         {
            BSUIDataManager.dispatchEvent(new Event(CampBuildsShared.CAMP_SLOTS_OPEN_STORE));
         }
         else if(!this.isActive)
         {
            this.onExpand();
         }
         else
         {
            this.List_mc.disableInput = true;
            this.CampBuildsActivationFlyout_mc.showFlyout(this.List_mc.selectedEntry);
         }
      }
      
      private function onCampBuildsListSelectionChange(param1:Event) : void
      {
         GlobalFunc.PlayMenuSound(CampBuildsShared.CAMP_SLOTS_HIGHLIGHT_SOUND);
      }
      
      private function onFlyoutShow(param1:Event) : void
      {
         this.setDarkened(true);
      }
      
      private function onFlyoutHide(param1:Event) : void
      {
         if(this.isActive)
         {
            this.setDarkened(false);
            this.List_mc.disableInput = false;
            stage.focus = this.List_mc;
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         switch(currentLabel)
         {
            case "on":
            case "darkened":
               this.Header_mc.NavText_tf.text = "$COLLAPSE";
               this.m_ExpandButton.ButtonVisible = false;
               this.m_CollapseButton.ButtonVisible = true;
               _loc2_ = 0;
               while(_loc2_ < this.List_mc.entryData.length)
               {
                  if(this.List_mc.entryData[_loc2_].isActive)
                  {
                     this.List_mc.selectedIndex = _loc2_;
                     break;
                  }
                  _loc2_++;
               }
               this.List_mc.maxRows = this.EXPANDED_MAX_ROWS;
               this.List_mc.scrollVertical = true;
               this.List_mc.showSelectedItem = true;
               removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
               break;
            case "off":
            case "off2":
               this.Header_mc.NavText_tf.text = "$EXPAND";
               this.m_ExpandButton.ButtonVisible = true;
               this.m_CollapseButton.ButtonVisible = false;
               removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         if(!this.isActive && this.m_CampBuildsRect.contains(stage.mouseX,stage.mouseY))
         {
            if(this.m_ExpandButton.ButtonVisible)
            {
               this.onExpand();
            }
         }
      }
      
      private function setVisitorIcons(param1:Array) : void
      {
         var _loc2_:* = 0;
         while(_loc2_ < this.m_VisitorIcons.length)
         {
            if(Boolean(param1) && param1.length > _loc2_)
            {
               this.m_VisitorIcons[_loc2_].LoadInternal(GlobalFunc.GetAccountIconPath(param1[_loc2_].szAvatarID),GlobalFunc.STORE_IMAGE_TEXTURE_BUFFER);
            }
            else
            {
               this.m_VisitorIcons[_loc2_].Unload();
            }
            _loc2_++;
         }
      }
      
      internal function __setTab_HeaderBG_mc_CampBuilds_HeaderBG_mc_0() : *
      {
         this.HeaderBG_mc.tabIndex = 5;
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame8() : *
      {
         stop();
      }
      
      internal function frame15() : *
      {
         stop();
      }
      
      internal function frame16() : *
      {
         stop();
      }
   }
}

