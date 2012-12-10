package front 
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;
	/**
	 * ...
	 * @author umhr
	 */
	public class RedLine extends Sprite
	{
		private static var _instance:RedLine;
		public function RedLine(block:SingletonBlock){init();}
		public static function getInstance():RedLine{
			if ( _instance == null ) {_instance = new RedLine(new SingletonBlock());};
			return _instance;
		}
		
		private var _mousePoint:Array/*Point*/= [];
		private function init():void
		{
            _mousePoint.unshift(new Point(mouseX, mouseY));
            _mousePoint.unshift(new Point(mouseX, mouseY));
            
            this.addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private var _mX:Number = 0;
		private var _mY:Number = 0;
		
		public function setXY(x:Number,y:Number):void {
			_mX = x;
			_mY = y;
		}
		
        private function onEnter(e:Event):void 
        {
			//mouseX, mouseX;
			calc(_mX, _mY);
            
        }
        
        /**
         * 線を描画
         * @param    mousePoint
         */
        private function draw(mousePoint:Array/*Point*/):void {
            this.graphics.clear();
            this.graphics.lineStyle(0, 0xFF0000);
            this.graphics.moveTo(mousePoint[0].x, mousePoint[0].y);
            var n:int = mousePoint.length;
            for (var i:int = 1; i < n; i++) {
                this.graphics.lineTo(mousePoint[i].x, mousePoint[i].y);
            }
        }
		private function calc(x:Number,y:Number):void {
            var p0:Point = _mousePoint[0];
            var p1:Point = _mousePoint[1];
            
            var inertiaPoint:Point = p0.subtract(p1).add(p0);
            
            inertiaPoint.x = inertiaPoint.x*0.9 + x * 0.1;
            inertiaPoint.y = inertiaPoint.y*0.9 + y * 0.1;
            
            _mousePoint.unshift(inertiaPoint);
            _mousePoint.splice(100);
            draw(_mousePoint);
		}
		
	}
	
}
class SingletonBlock { };