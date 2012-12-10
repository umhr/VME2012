package  
{
	
	import flare.system.Device3D;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author umhr
	 */
	public class Diagram extends Sprite 
	{
		static private var _textField:TextField;
		public function Diagram() 
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
			
			addChild(getTextField(stage.stageWidth, 0));
			
			//addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(event:Event):void 
		{
			//Diagram.update();
		}
		
		static private function getTextField(x:int, y:int):TextField {
			if (!_textField) {
				_textField = new TextField();
			}
			_textField.defaultTextFormat = new TextFormat("_sans", 9, 0xFFFFFF);
			//_textField.textColor = 0xFF0000;
			_textField.width = 100;
			_textField.height = 60;
			_textField.x = x - _textField.width;
			_textField.y = y;
			_textField.mouseEnabled = false;
			_textField.selectable = false;
			return _textField;
		}
		
		static public function update():void {
			var text:String = "";
			text += "FrameCount:" + String(Device3D.frameCount) + "\n";
			text += "DrawCalls:" + String(Device3D.drawCalls) + "\n";
			text += "Objects:" + String(Device3D.objectsDrawn) + "\n";
			text += "Triangles:" + String(Device3D.trianglesDrawn).replace(/(\d)(?=(\d\d\d)+$)/g, "$1,");
			_textField.text = text;
		}
		
	}
	
}