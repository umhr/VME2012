package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import front.FrontCanvas;
	import jp.mztm.umhr.logging.Log;
	import net.hires.debug.Stats;
	
	/**
	 * ...
	 * @author umhr
	 */
	[SWF(frameRate = 60, width = 590, height = 590, backgroundColor = 0x000000)]
	public class Main extends Sprite 
	{
		private var _playControl:PlayControl;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			playControl_click(null);
			
			return;
			_playControl = new PlayControl(true, "tr");
			_playControl.addEventListener(MouseEvent.CLICK, playControl_click);
			addChild(_playControl);
			
		}
		
		private function playControl_click(e:MouseEvent):void 
		{
			//_playControl.removeEventListener(MouseEvent.CLICK, playControl_click);
			stage.displayState = "fullScreen";
			
			//addChild(new CubeMeshEarth());
			addChild(CubeMeshEarthManager.getInstance());
			//addChild(_playControl);
			addChild(new Stats());
			
			//addChild(new Log(100, 0, 100, 100));
			
			addChild(new Diagram());
			
			addChild(new FrontCanvas());
			
		}
		
	}
	
}