package  
{
	import flare.basic.*;
	import flare.core.Camera3D;
	import flare.system.*;
	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.geom.Vector3D;
	import flash.text.*;
	import front.RedEye;
	import front.RedLine;
	import front.TriLine;
	import jp.mztm.umhr.logging.Log;
	import mesh.*;
	/**
	 * ...
	 * @author umhr
	 */
	public class CubeMeshEarthManager extends Sprite 
	{
		private static var _instance:CubeMeshEarthManager;
		public function CubeMeshEarthManager(block:SingletonBlock){init();}
		public static function getInstance():CubeMeshEarthManager{
			if ( _instance == null ) {_instance = new CubeMeshEarthManager(new SingletonBlock());};
			return _instance;
		}
		
		[Embed(source = "earthmap500b.png")]
		public var mapEmbed:Class;
		
		private var _scene:Scene3D;
		private var _cubes:CubesMesh;
		private var _count:Number = 0;
		private function init():void
		{
			if (stage) startUp();
			else addEventListener(Event.ADDED_TO_STAGE, startUp);
		}
		
		private function startUp(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, startUp);
			// entry point
			stage.scaleMode = "noScale";
			stage.align = "tl";
			
			_scene = new Viewer3D( this );
			_scene.camera.setPosition( 0, 0, -600 );
			
			// 背景色 デフォルト(0.25,0.25,0.25)
			_scene.clearColor.setTo(0, 0, 0);
			
			// アンビエント色 デフォルト(0.3,0.3,0.3)
			_scene.lights.ambientColor.setTo(0.4, 0.4, 0.4);
			
			_cubes = new CubesMesh();
			
			var map:Bitmap = new mapEmbed();
			
			_cubes.setTtexture((new mapEmbed() as Bitmap).bitmapData);
			
			var w:int;
			var h:int = 100;
			var scale:int = 300;
			
			for (var i:int = 0; i < h; i++) {
				var radius:Number = Math.sin(180 * (i / h) * (Math.PI / 180));//半径
				w = Math.PI * 2 * radius * h * 0.5 * 0.5;
				w = Math.max(w, 1);
                for (var j:int = 0; j < w; j++) {
					
                    var rx:Number = Math.PI * (2 * (j - (w - 1) / 2) / w);
                    var ry:Number = Math.PI * ((i - (h - 1) / 2) / h);
                    var nx:Number = Math.cos(ry) * Math.sin(rx) * scale;
                    var ny:Number = Math.sin(ry) * scale;
                    var nz:Number = Math.cos(ry) * Math.cos(rx) * scale;
					
					_cubes.addCube( -nx, -ny, nz, 7, (j / w), (i / h), [0, 0, 0]);
					
					var ran:Number;
					
					for (var k:int = 0; k < 10; k++) 
					{
						ran = Math.random() * 0.85 + 0.1;
						_cubes.addCube( -nx*ran, -ny*ran, nz*ran, 7*ran, (j / w), (i / h), [0, 0, 0]);
					}
					
                }
            }
			
			//trace(_cubes.length);
			
			_scene.addChild( _cubes );
			
			_scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
			
		}		
		
		private function updateEvent(e:Event):void 
		{
			if (PlayControl.isPause) {
				_cubes.stop();
				return;
			}
			Diagram.update();
			
			if ( !Input3D.mouseDown )
			{
				_count++
				_cubes.rotateX( 0.03 );
				_cubes.rotateY( -0.22 );
				_scene.camera.translateZ( Math.sin( _count / 300 ) * 1.5 );
			}
		}
		
		private var rZ:Number = 0;
		public function move(x:Number, y:Number):void {
			TriLine.getInstance().setXY(x * stage.stageWidth, y * stage.stageHeight);
			
			//rZ += ((y-0.5)+(x-0.5))/1000;
			//_cubes.rotateZ( rZ );
		}
		
	}
	
}
class SingletonBlock { };