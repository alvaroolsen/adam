package  {
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.*;
	import flash.geom.*;
	
	public class God extends MovieClip{
		private static var _instance:God;
		
		public var _rand:Number = new Number();
		
		
		public var cX = new Number();
		public var cY = new Number();
		public var COTU:Point
		public var LIGHT:Boolean = new Boolean();
		
		public var adam = new homoerectus('m');
		public var eve = new homoerectus('f');
		//public var adam2 = new homoerectus('m');
		//public var adam3 = new homoerectus('m');
		//public var adam4 = new homoerectus('m');
		//public var adam5 = new homoerectus('m');
		
		public var population:Array = new Array();
		

		public function God() {
			// constructor code
			_instance = this;
			trace("Hello, I am God");
			
			cX = stage.stageWidth / 2;
			cY = stage.stageHeight / 2;
			COTU = new Point(cX, cY);
			LIGHT = true;
			
			addEventListener(Event.ADDED_TO_STAGE, ini)
		}
		
		public static function get instance():God { return _instance; }
		
		public function ini(e:Event){
			
			adam.x = COTU.x - 20;
			adam.y = COTU.y;
			addChild(adam);
			
			eve.x = COTU.x+ 20;
			eve.y = COTU.y;
			addChild(eve);
			
			/*for(var i=0; i<1; i++){
				population.push(new homoerectus("m"));
				addChild(population[i]);
				population[i].walk(e);
				population[i].x = COTU.x;
				population[i].y = COTU.y + i*10;
			}*/
			
			
		
			//stage.
			//adam.addEventListener(MouseEvent.MOUSE_DOWN, pickUp);
			//adam.addEventListener(MouseEvent.MOUSE_UP, dropIt);
				
		}
		
		
		
		
		
		
		
		
		public function randomRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		

	}
	
}
