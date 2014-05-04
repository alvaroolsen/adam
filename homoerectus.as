//this 

package  {
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.sampler.NewObjectSample;
	import flash.geom.*;
	
	public class homoerectus extends MovieClip {
		//adds the instance to a static variable 
		private static var _instance:homoerectus;
		
		public var GENDER:String = new String();
		
		public var SLEEP:Boolean = new Boolean();
		public var isWalking:Boolean = false;
		
		
		public var mind:Mind = new Mind(); // this is a rabbit's hole
		private var me:MovieClip = mind;
		//public var motor:Motor = new Motor();

		//
		public var sleep_color:ColorTransform = new ColorTransform(); // aesthetics for feedback
		public var wake_color:ColorTransform = new ColorTransform(); // aesthetics for feedback
		//public var vis:Vision = new Vision();
		
		//motion
		public var myTimer:Timer;
		public var _rand:Number = new Number();
		
		public var SPEED:Number = 2;
		
		public function homoerectus(gender:String) {
			// constructor code''
			_instance = this;
			
			GENDER = gender;
			mind.CONCS = true;
			SLEEP = false;
			mind.GOAL = true;
			_rand = randomRange(0, 4);
			mind.decideDirection(_rand);
			sleep_color.color = 0xcccccc;
			wake_color.color = 0xFF0000;
		
			addEventListener(Event.ADDED_TO_STAGE, ini);
			addEventListener(Event.ENTER_FRAME, life);
		}
		
		public static function get instance():homoerectus { return _instance; }
		
		
		public function life(e:Event){
			//handle remote sleep and awakening modes
			//this should eventually be self-driven
			if(SLEEP){
				this.removeEventListener(MouseEvent.CLICK, sleep);
				this.addEventListener(MouseEvent.CLICK, wake);
			}else{
				this.removeEventListener(MouseEvent.CLICK, wake);
				this.addEventListener(MouseEvent.CLICK, sleep);
				//this.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
			}
		}
		
		public function ini(e:Event){
			trace("//////////////BODY//////////////////////////")

			trace("hello I am homoerectus. - " + GENDER + " - "+this.name);
			trace("consciousness "+mind.CONCS);
			if(mind.CONCS&&!SLEEP){trace("I am Conscious. Teach me!"); }
			this.addEventListener(MouseEvent.MOUSE_DOWN, pickUp);
			this.addEventListener(MouseEvent.MOUSE_UP, dropIt);
			this.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER, focusMe);
			
			_rand = randomRange(0,4);
			mind.decideDirection(_rand);
			mind.tempGoal = _rand;
			mind.motor.startWalking(this);
			
			trace("//////////////BODY/////END//////////////////");
		}
		
		public function focusMe(e:MouseEvent){
			stage.focus = this;
		}
		
		//This function might be integrated as a function of mind instead
		public function disconnectEvents(){
			this.removeEventListener(MouseEvent.CLICK, sleep);
			this.removeEventListener(MouseEvent.CLICK, wake);
		}
		
		public function connectEvents(){
			
			if(SLEEP){
				this.removeEventListener(MouseEvent.CLICK, sleep);
				this.addEventListener(MouseEvent.CLICK, wake);
			}else{
				this.removeEventListener(MouseEvent.CLICK, wake);
				this.addEventListener(MouseEvent.CLICK, sleep);
			}
		}
		
		public function sleep(e:MouseEvent){
				trace("HE: Sleeping...");
				mind.CONCS = false;
				SLEEP = true;
				//removeEventListener(Event.ENTER_FRAME, motor.walk);
				removeEventListener(MouseEvent.CLICK, sleep);
				this.vision.stop();
				this.vision.transform.colorTransform = sleep_color;
				//	do some dreaming stuff here
		}
		
		public function wake(e:MouseEvent){
				mind.CONCS = true;
				SLEEP = false;
				this.vision.play();
				this.vision.transform.colorTransform = wake_color;
				ini(e)
		}
		
		public function walk(e:Event){
			
			if(!isWalking){
				me = mind as MovieClip
				addEventListener(Event.ENTER_FRAME, walk);
				//trace("---"+this+" is walking.")
				isWalking = true;
			}
				
			//detectPath()
			if(me._e){
				this.x += SPEED;
				this.rotation = 90;
				//vis.x = 50
				//trace(this.width)
				//vis.y = this.height/2;
				//vis.rotation = 90;
				me.detectPath(this); //detect if anything is infront
			}else if(me._w){
				this.x -= SPEED;
				//vis.x = -50
				//vis.y = this.height/2;
				me.detectPath(this);
				this.rotation = -90;
				
			}else if(me._n){
				this.y -= SPEED;
				//vis.y = -50
				//vis.x = this.width/2;
				me.detectPath(this);
				this.rotation = 0;
			}else if(me._s){
				//vis.y = 50
				//vis.x = this.width / 2;
				me.detectPath(this);
				this.rotation = 180;
				this.y += SPEED;
			}
				
			
		}
		
		public function pickUp(event:MouseEvent):void
		{
			// no longer need to keep track of startX & startY here because that's already been done up above
			event.target.startDrag(true);
			//event.target.parent.addChild(event.target);
		}
		
		public function dropIt(event:MouseEvent):void
		{
			event.target.stopDrag();
		}
		
		public function keyboardHandler(e:KeyboardEvent){
			
				if(e.charCode == 13){
					//trace("Change Something - De Ja Vou")
					_rand = randomRange(0, 4);
					mind.decideDirection(_rand);
					mind.tempGoal = _rand;
					mind.motor.startWalking(this);
					
				   // your code here
				   // doSomething();
			   }
			   
			   if(e.keyCode == 38){ // north
					mind.decideDirection(0);
					mind.tempGoal= 0;
				    mind.motor.startWalking(this);
			   }
			   if(e.keyCode == 39){ //east
					mind.decideDirection(1);
				    mind.tempGoal = 1;
				    mind.motor.startWalking(this);
			   }
			   if(e.keyCode == 37){ //west
					mind.decideDirection(2);
				    mind.tempGoal = 2;
				    mind.motor.startWalking(this);
			   }
			   if(e.keyCode == 40){ // south
					mind.decideDirection(3);
				    mind.tempGoal = 3
					mind.motor.startWalking(this);
			   }
			   
		}
		
		
		public function randomRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
	}
	
}
