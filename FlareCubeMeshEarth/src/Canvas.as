package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

    /**
     * ...
     * @author umhr
     */
    [SWF(width = 465, height = 465, backgroundColor = 0x000000, frameRate = 30)]
    public class Canvas extends Sprite
    {
        private var _mousePoint:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>();
        private var _count:int;
        private var _shape:Shape = new Shape();
        public function Canvas():void
        {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }

        private function init(e:Event = null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            // entry point
            
            this.addChild(_shape);

            var point:Point = new Point(mouseX, mouseY);
            for (var i:int = 0; i < 3; i++) {
                var vector:Vector.<Point> = new Vector.<Point>();
                for (var j:int = 0; j < 20; j++) {
                    vector[j] = point;
                }
                _mousePoint[i] = vector;
            }
            
            this.addEventListener(Event.ENTER_FRAME, onEnter);
            
        }

        private function onEnter(e:Event):void
        {
            _count++;
            for (var i:int = 0; i < 3; i++) {
                var inertiaPoint:Point = _mousePoint[i][0].subtract(_mousePoint[i][1]).add(_mousePoint[i][0]);
                var radian:Number = _count / 6 + Math.PI * 2 * i / 3;
                var r:Number = 10 * (1 + 1 * Math.sin(_count / 12));
                var mousePoint:Point = new Point(mouseX + Math.cos(radian) * r , mouseY + Math.sin(radian) * r);
                inertiaPoint.x = inertiaPoint.x * 0.97 + mousePoint.x * 0.03;
                inertiaPoint.y = inertiaPoint.y * 0.97 + mousePoint.y * 0.03;
                _mousePoint[i].unshift(inertiaPoint);
                _mousePoint[i].length = 20;
            }
            draw(_mousePoint);
        }

        /**
         * 線を描画
         * @param    mousePoint
         */
        private function draw(mousePoint:Vector.<Vector.<Point>>):void {
            _shape.graphics.clear();
            var colors:Array = [0xFF0000, 0x00FF00, 0x0000FF];
            for (var i:int = 0; i < 3; i++) {
                _shape.graphics.lineStyle(4, colors[i]);
                var m0:Point = Point.interpolate(mousePoint[i][0], mousePoint[i][1], 0.5);
                var m1:Point = Point.interpolate(mousePoint[i][1], mousePoint[i][2], 0.5);
                var m2:Point = Point.interpolate(mousePoint[i][2], mousePoint[i][3], 0.5);
                var m3:Point = Point.interpolate(mousePoint[i][3], mousePoint[i][4], 0.5);
                var m4:Point = Point.interpolate(mousePoint[i][4], mousePoint[i][5], 0.5);
                var m5:Point = Point.interpolate(mousePoint[i][5], mousePoint[i][6], 0.5);
                var m6:Point = Point.interpolate(mousePoint[i][6], mousePoint[i][7], 0.5);
                var m7:Point = Point.interpolate(mousePoint[i][7], mousePoint[i][8], 0.5);
                var m8:Point = Point.interpolate(mousePoint[i][8], mousePoint[i][9], 0.5);
                var m9:Point = Point.interpolate(mousePoint[i][9], mousePoint[i][10], 0.5);
                var m10:Point = Point.interpolate(mousePoint[i][10], mousePoint[i][11], 0.5);
                _shape.graphics.moveTo(m0.x, m0.y);
                _shape.graphics.curveTo(mousePoint[i][1].x, mousePoint[i][1].y, m1.x, m1.y);
                _shape.graphics.curveTo(mousePoint[i][2].x, mousePoint[i][2].y, m2.x, m2.y);
                _shape.graphics.curveTo(mousePoint[i][3].x, mousePoint[i][3].y, m3.x, m3.y);
                _shape.graphics.curveTo(mousePoint[i][4].x, mousePoint[i][4].y, m4.x, m4.y);
                _shape.graphics.curveTo(mousePoint[i][5].x, mousePoint[i][5].y, m5.x, m5.y);
                _shape.graphics.curveTo(mousePoint[i][6].x, mousePoint[i][6].y, m6.x, m6.y);
                _shape.graphics.curveTo(mousePoint[i][7].x, mousePoint[i][7].y, m7.x, m7.y);
                _shape.graphics.curveTo(mousePoint[i][8].x, mousePoint[i][8].y, m8.x, m8.y);
                _shape.graphics.curveTo(mousePoint[i][9].x, mousePoint[i][9].y, m9.x, m9.y);
                _shape.graphics.curveTo(mousePoint[i][10].x, mousePoint[i][10].y, m10.x, m10.y);
            }
            //_bitmap.bitmapData.colorTransform(_bitmap.bitmapData.rect, FADE);
            //_bitmap.bitmapData.draw(_shape, null, null, "add");
        }
    }

}
