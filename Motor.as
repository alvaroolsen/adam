//physical functions of automaticity like walking are here

package{
	
	import flash.display.*;
	import flash.events.*;
	
	public class Motor extends MovieClip {
		
		public var god:MovieClip = God.instance;
		public var body:MovieClip = new MovieClip();//homoerectus.instance;
		
		public function Motor() {
			// constructor code
			super();
			god = God.instance;
			body = homoerectus.instance;
			
			trace("Motor Capacities Loaded")
			
			this.addEventListener(Event.ADDED_TO_STAGE, ini);
		}
		
		public function ini(e:Event){
			
			//trace(body + "aware");
			trace("...motor...")
		}
		
		//Motor function we leave it at the behaviour of the body: homoerectus for the moment
		public function startWalking(b:Object){
			trace("walk starts...")
			b.addEventListener(Event.ENTER_FRAME, b.walk);
			b.isWalking = true;
			trace(b.isWalking)
		
		}
		
		public function stopWalking(b:Object){
			//b = body
			trace("stopWalking")
			trace( b+" "+b.name );
			b.removeEventListener(Event.ENTER_FRAME, b.walk);
			b.isWalking = false;
		}
		
		
	}
	
}
