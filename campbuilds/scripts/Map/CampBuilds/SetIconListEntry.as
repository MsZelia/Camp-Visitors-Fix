package Map.CampBuilds
{
   import Shared.AS3.BSScrollingListEntry;
   import fl.motion.AdjustColor;
   import flash.display.MovieClip;
   import flash.filters.ColorMatrixFilter;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol35")]
   public class SetIconListEntry extends BSScrollingListEntry
   {
      
      private var DisabledFilter:ColorMatrixFilter;
      
      private var DISABLED_TEXT_COLOR:Number = 5596012;
      
      public var CustomIconHolder_mc:MovieClip;
      
      public function SetIconListEntry()
      {
         super();
         var _loc1_:AdjustColor = new AdjustColor();
         _loc1_.hue = 0;
         _loc1_.saturation = -51;
         _loc1_.brightness = 67;
         _loc1_.contrast = -48;
         this.DisabledFilter = new ColorMatrixFilter(_loc1_.CalculateFinalFlatArray());
         this.mouseChildren = false;
      }
      
      override public function SetEntryText(param1:Object, param2:String) : *
      {
         var _loc3_:Class = CampBuildsShared.getCustomIconClipClass(param1.customIcon);
         var _loc4_:MovieClip = new _loc3_() as MovieClip;
         super.SetEntryText(param1,param2);
         this.CustomIconHolder_mc.removeChildren();
         _loc4_.useFlyoutScale = true;
         this.CustomIconHolder_mc.addChild(_loc4_);
      }
   }
}

