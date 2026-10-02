package Map.CampBuilds
{
   import Shared.AS3.BSScrollingListEntry;
   import fl.motion.AdjustColor;
   import flash.filters.ColorMatrixFilter;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol38")]
   public class CampBuildsActivationListEntry extends BSScrollingListEntry
   {
      
      private var DisabledFilter:ColorMatrixFilter;
      
      private var DISABLED_TEXT_COLOR:Number = 5596012;
      
      public function CampBuildsActivationListEntry()
      {
         super();
         var _loc1_:AdjustColor = new AdjustColor();
         _loc1_.hue = 0;
         _loc1_.saturation = -51;
         _loc1_.brightness = 67;
         _loc1_.contrast = -48;
         this.DisabledFilter = new ColorMatrixFilter(_loc1_.CalculateFinalFlatArray());
         this.mouseChildren = false;
         TextFieldEx.setTextAutoSize(textField,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
   }
}

