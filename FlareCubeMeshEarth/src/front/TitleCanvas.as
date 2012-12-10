package front 
{
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author umhr
	 */
	public class TitleCanvas extends Sprite 
	{
		
		[Embed(source = "title.png")]
		public var titleEmbed:Class;
		
		public function TitleCanvas() 
		{
			init();
		}
		private function init():void 
		{
            if (stage) onInit();
            else addEventListener(Event.ADDED_TO_STAGE, onInit);
        }
        
        private function onInit(event:Event = null):void 
        {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			//(new titleEmbed() as Bitmap).bitmapData
			
			var title:Bitmap = new titleEmbed() as Bitmap;
			
			title.scaleX = title.scaleY = stage.stageWidth / 4800;
			
			addChild(title);
			
		}
	}
	
}