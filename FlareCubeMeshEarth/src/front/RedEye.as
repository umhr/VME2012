package front 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author umhr
	 */
	public class RedEye extends Sprite
	{
		private static var _instance:RedEye;
		public function RedEye(block:SingletonBlock){init();}
		public static function getInstance():RedEye{
			if ( _instance == null ) {_instance = new RedEye(new SingletonBlock());};
			return _instance;
		}
		
		
		private function init():void
		{
			graphics.beginFill(0xFF0000, 0.5);
			graphics.drawCircle(0, 0, 10);
			graphics.endFill();
			
		}
		
		
	}
	
}
class SingletonBlock { };