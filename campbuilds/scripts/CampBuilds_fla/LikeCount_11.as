package CampBuilds_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol13")]
   public dynamic class LikeCount_11 extends MovieClip
   {
      
      public var LikeCount_tf:TextField;
      
      public function LikeCount_11()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         gotoAndPlay(Math.random() * 80) + 1;
      }
   }
}

