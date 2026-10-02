package Map.CampBuilds
{
   import Shared.AS3.BSScrollingListEntry;
   import Shared.AS3.SWFLoaderClip;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol28")]
   public class CampBuildsEntry extends BSScrollingListEntry
   {
      
      public static const COLOR_BLACK:* = 0;
      
      public var Icon_mc:SWFLoaderClip;
      
      public var HeaderText_tf:TextField;
      
      public var StatusText_tf:TextField;
      
      public var CampBuildsEntryBg_mc:MovieClip;
      
      public var ActiveBox_mc:MovieClip;
      
      public var PlusSymbol_mc:MovieClip;
      
      public var BestBuildsIcon_mc:MovieClip;
      
      public var LikeCount_mc:MovieClip;
      
      private var m_BudgetUsed:Number = 0;
      
      private var m_BudgetStored:Number = 0;
      
      private var m_BudgetTotal:Number = 0;
      
      private var m_IsActive:Boolean = false;
      
      private var m_IsPlaced:Boolean = false;
      
      private var m_IsBlocked:Boolean = false;
      
      private var m_CanFastTravel:Boolean = false;
      
      private var m_Name:String = "";
      
      private var m_IconOriginalWidthHeight:Point;
      
      private var m_LikeCountViewed:Boolean = false;
      
      private var m_BestBuildsIcon:MovieClip = null;
      
      private var m_Icon:MovieClip = null;
      
      public function CampBuildsEntry()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
         this.m_IconOriginalWidthHeight = new Point(this.Icon_mc.width,this.Icon_mc.height);
         this.BestBuildsIcon_mc.visible = false;
         this.LikeCount_mc.visible = false;
         TextFieldEx.setTextAutoSize(this.HeaderText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.StatusText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.LikeCount_mc.LikeCount_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      public function get bugetUsed() : Number
      {
         return this.m_BudgetUsed;
      }
      
      public function get budgetStored() : Number
      {
         return this.m_BudgetStored;
      }
      
      public function get budgetTotal() : Number
      {
         return this.m_BudgetTotal;
      }
      
      public function get isActive() : Boolean
      {
         return this.m_IsActive;
      }
      
      public function get isPlaced() : Boolean
      {
         return this.m_IsPlaced;
      }
      
      public function get isBlocked() : Boolean
      {
         return this.m_IsBlocked;
      }
      
      public function get canFastTravel() : Boolean
      {
         return this.m_CanFastTravel;
      }
      
      public function get campName() : String
      {
         return this.m_Name;
      }
      
      override public function SetEntryText(param1:Object, param2:String) : *
      {
         if(param1)
         {
            this.m_BudgetUsed = param1.budgetUsed;
            this.m_BudgetStored = param1.budgetStored;
            this.m_IsActive = param1.isActive;
            this.m_CanFastTravel = param1.canFastTravel;
            this.m_IsPlaced = param1.isPlaced;
            this.m_IsBlocked = param1.isBlocked;
            if(param1.isUnlockable)
            {
               gotoAndStop("newSlot");
               if(this.HeaderText_tf.text != param1.customName)
               {
                  TextFieldEx.setTextAutoSize(this.HeaderText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
               }
               this.HeaderText_tf.text = GlobalFunc.LocalizeFormattedString("$CAMP_SLOTS_NEWSLOT");
            }
            else
            {
               gotoAndStop("standard");
               if(this.HeaderText_tf.text != param1.customName)
               {
                  TextFieldEx.setTextAutoSize(this.HeaderText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
               }
               this.HeaderText_tf.text = GlobalFunc.GenerateNameAndTitle(param1.customName);
               if(this.m_IsBlocked)
               {
                  this.StatusText_tf.text = GlobalFunc.LocalizeFormattedString("$CAMP_SLOTS_STATUS_BLOCKED");
               }
               else if(!this.m_IsPlaced && !this.m_IsActive)
               {
                  this.StatusText_tf.text = GlobalFunc.LocalizeFormattedString("$CAMP_SLOTS_STATUS_UNPLACED");
               }
               else if(this.m_IsActive && !this.m_IsPlaced)
               {
                  this.StatusText_tf.text = GlobalFunc.LocalizeFormattedString("$CAMP_SLOTS_STATUS_ACTIVE_UNPLACED");
               }
               else if(this.m_IsPlaced && !this.m_IsActive)
               {
                  this.StatusText_tf.text = GlobalFunc.LocalizeFormattedString("$CAMP_SLOTS_STATUS_STORED");
               }
               else
               {
                  this.StatusText_tf.text = GlobalFunc.LocalizeFormattedString("$CAMP_SLOTS_STATUS_ACTIVE_PLACED");
               }
            }
            this.ActiveBox_mc.visible = this.m_IsActive;
            if(param1.canManageBestBuild)
            {
               this.Icon_mc.visible = false;
               this.BestBuildsIcon_mc.visible = true;
               if(this.m_BestBuildsIcon)
               {
                  this.BestBuildsIcon_mc.CustomIconHolder_mc.removeChild(this.m_BestBuildsIcon);
               }
               this.m_BestBuildsIcon = this.BestBuildsIcon_mc.CustomIconHolder_mc.setContainerIconClip(CampBuildsShared.getCampIconStringFromIndex(param1.bestBuildIcon));
               this.BestBuildsIcon_mc.CustomIconHolder_mc.scaleX = 1.25;
               this.BestBuildsIcon_mc.CustomIconHolder_mc.scaleY = 1.25;
            }
            else
            {
               this.BestBuildsIcon_mc.visible = false;
               this.Icon_mc.visible = true;
               if(this.m_Icon)
               {
                  this.Icon_mc.removeChild(this.m_Icon);
               }
               this.m_Icon = this.Icon_mc.setContainerIconClip(CampBuildsShared.getCampIconStringFromIndex(param1.customIcon));
               this.Icon_mc.getChildAt(0).width = this.m_IconOriginalWidthHeight.x / this.Icon_mc.scaleX;
               this.Icon_mc.getChildAt(0).height = this.m_IconOriginalWidthHeight.y / this.Icon_mc.scaleY;
            }
            this.LikeCount_mc.LikeCount_tf.text = param1.likeCountUpdate;
            this.LikeCount_mc.visible = !this.m_LikeCountViewed && Boolean(param1.likeCountUpdate) && param1.likeCountUpdate != 0;
            if(this.selected)
            {
               this.m_LikeCountViewed = true;
               this.HeaderText_tf.textColor = COLOR_BLACK;
               this.StatusText_tf.textColor = COLOR_BLACK;
               if(!param1.isUnlockable)
               {
                  this.ActiveBox_mc.gotoAndStop("selected");
               }
               else
               {
                  this.PlusSymbol_mc.gotoAndStop("selected");
               }
               this.CampBuildsEntryBg_mc.gotoAndStop("selected");
            }
            else
            {
               if(this.m_LikeCountViewed)
               {
                  this.LikeCount_mc.visible = false;
               }
               this.HeaderText_tf.textColor = GlobalFunc.COLOR_TEXT_BODY;
               this.StatusText_tf.textColor = GlobalFunc.COLOR_TEXT_BODY;
               if(!param1.isUnlockable)
               {
                  this.ActiveBox_mc.gotoAndStop("unselected");
               }
               else
               {
                  this.PlusSymbol_mc.gotoAndStop("unselected");
               }
               this.CampBuildsEntryBg_mc.gotoAndStop("unselected");
            }
         }
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}

