package  {
	
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.Timer;
    import flash.events.*;
	import flash.ui.Keyboard;
    import flash.sampler.NewObjectSample;
	
	public class Mind extends MovieClip{
		
		//prior knowledge and defaults
		public var CONCS:Boolean = new Boolean();
		
		//learning object
		public var beh:Behaviorism = new Behaviorism();
		public var cog:Cognition = new Cognition();
		public var cons:Constructivism = new Constructivism();
		
		//control object
		public var motor:Motor = new Motor();;
		
		//Goals 
		public var GOAL:Boolean = new Boolean();
		public var GOALTIME:Number = 0; // may be used for efficiency measures
		public var O_GOALS:Array = new Array(); //overall mind.GOALs
		public var tempGoal:Number = new Number();
		
		//Random and times vars
		public var myTimer:Timer;
		public var _rand:Number = new Number();
		
		//parent access
		public var god:MovieClip = God.instance;
		public var body:MovieClip = new MovieClip();
		//motion
		public var O_DIRECTIONS:Array = new Array(); // overall directions n,e,w,s
		public var _n:Boolean = false;
		public var _e:Boolean = false;
		public var _w:Boolean = false;
		public var _s:Boolean = false;
		
		//encountered objects basic properties (x, y, w, h)
		public var ox:Number;
		public var oy:Number;
		public var ow:Number;
		public var oh:Number;
	
		//Navigation and "Self of Physical awareness"
		public var me_x:Number;
		public var me_y:Number;
		public var me_w:Number;
		public var me_h:Number;
		public var decX:Number;
		public var decY:Number;
		public var deltaX:Number;
		public var deltaY:Number;
		public var strPointY:Number;
		public var endPointY:Number;
		public var strPointX:Number;
		public var endPointX:Number;
		public var lateralMid:Number;
		
		//can be used for anything, for example look at avoidObject()
		public var point1:Point;
		public var point2:Point;
		public var point3:Point;
		public var point4:Point;
		
		//used to determine where "i am" in relation to items in the world
		public var onLeft:Boolean = false;
		public var onRight:Boolean = false;
		public var onBottom:Boolean = false;
		public var onTop:Boolean = false;
		
		//Behavioral learning scale
		public var skill:Number = 0;
		public var evaluation:Boolean = new Boolean();
		
		
		public function Mind() {
			// constructor code
			
			super();
			
			body = homoerectus.instance;
			//var motor:Motor = new Motor(b);
			//startGoal("walk");
			//god = God.instance;
			//body = homoerectus.instance;
			trace("Mind Engaged");
			
			O_GOALS = ["physiological", "safety", "belong", "emotional", "actualization"];
			addEventListener(Event.ADDED_TO_STAGE, mindINI)
		}
		
		public function mindINI(e:Event){
			
			
		   

			//trace(",.;',.;',.;,'.;,'.;,.;,'.;,'.,;'.,';.,.';,.',;.',;.',;.,';.,';.")
			//trace(god);
			//trace(body);
			//trace(",.;',.;',.;,'.;,'.;,.;,'.;,'.,;'.,';.,.';,.',;.',;.',;.,';.,';.")
			//if(!god){return;}
			//if(!body){return;}
			
			
		}
		
		public function whereAmI(o:Object){
			//get encountered object's info (x, y, w, h)
			ox = o.x;
			oy = o.y;
			ow = o.width;
			oh = o.height;
			//get self info (x, y, w, h)
			me_x = body.x;
			me_y = body.y;
			me_w = body.width;
			me_h = body.height;
			
			if(me_x < ox){trace("HE: I am on the left");}
			if(me_x > (ox + ow)){trace("HE: I am on the right")}
			if(me_y < oy){trace("HE: I am on the top")}
			if(me_y > oy){trace("HE: I am on the bottom");}
			if(me_y >= oy){trace("HE: I am over it and I can continue")}
		}
		
		public function startGoal(e:Event, a:String, g:Number){
			trace("staring Goal: "+ a );
			trace("staring Goal: "+ e );
			trace("staring Goal: "+ g );
			whereAmI(body);
			
			//god.addEventListener(Event.ENTER_FRAME, motor.walk);
		}
		
		/*public function startGoal(g:String){
			
			//start timer for expirations: this can potentially match prior 
			//knowledge on how long the task takes, also the prior knowledge 
			//can say the speed at which the system learns and becomes efficient - pending
			/*
			god = God.instance;
			body = homoerectus.instance;
			trace(body+"---")
			if(CONCS){
				
				var myTimer:Timer = new Timer(1000);
				myTimer.addEventListener("timer", this.GoalTime);
				//myTimer.start();
				if(g=="walk"){
					trace("walking")
					god.addEventListener(Event.ENTER_FRAME, motor.walk);
					
				}
				
			}
			
			
			//checks if body is asleep
			
			if(!body.SLEEP){
				
			}else{
				
			}
			
		}
		
		public function GoalTime(event:TimerEvent){
			//mind.GOALTimer.text = mind.GOALTIME;
			if(CONCS){
				(parent as God).goalTimer.text = GOALTIME.toString();
				trace("timerHandler: " + GOALTIME);
				GOALTIME++;
			}
		}   */
		
		//Functions for Environment Interaction with Other Objects
		public function detectPath(o:MovieClip){
			//find out if there is anything infront of this
			
			//trace(God.instance.numChildren);
			
			god = God.instance;
			//body = homoerectus.instance;
			if(!god){return;}
			if(!body){return;}
			
			//trace("body:"+body+" X: "+ (body.x + 200) +" Y :"+ (body.y + 200));
			
			//trace(body)
			
			
			for(var i:int = 0, len:int = god.numChildren; i < len; i++){
				var child:DisplayObject = god.getChildAt(i);
				
				if(child != body && body.hitTestObject(child)){
					
					//trace("Collides with: "+" obj:"+god.getChildAt(i) +" " + god.getChildAt(i).x + " " + god.getChildAt(i).y);
					//trace(body);
					//Hardcoded Goal
					
					
					if(god.getChildAt(i).toString() == "[object danger_hotspot]"){
						
						trace("OMG! - NOT SAFE");
					}
					
					if(god.getChildAt(i).toString() == "[object Rock_obstacle]"){
						trace("ROCK - meh - Let me Walk Around it");
						avoidObject(body, god.getChildAt(i), 0);
					}
					
					if(god.getChildAt(i).toString() == "[object FoodItem]"){
							trace("IT'S FOOD! - Tip: Satisfies Level 1 of Human Needs");
					}
					
					if(god.getChildAt(i).toString() == "[object Water]"){
							trace("IT'S WATER! - Tip: Satisfies Level 1 of Human Needs");
					}
					
					if(god.getChildAt(i).toString() == "[object EOTW]"){
							trace("IT'S THE END OF THE WORLD - Let me walk away");
							avoidObject(body, god.getChildAt(i), 1);
					}
					
					
					
					
					
					
					
				}
			}
			
			//vis.x = 50

			//trace(vis.x);
				
		}

		public function avoidObject(b:Object, o:Object, severity:Number){
				trace("//////////////avoidObject()//////////////////////////////")
				trace(o+" "+o.name);
				
				
				//metadata - this might be a function of mind
				decX:Number;
				decY:Number;
				deltaX:Number;
				deltaY:Number;
			
				//stop to "think" how to go around or away from encountered object
			
				//set all directions to false
				this._n = false;
				this._e = false;
				this._w = false;
				this._s = false;
			
				//send Motor a stopwalking request
				motor.stopWalking(b);
			
				//find out where "I am" in relation to the object "I" needs to avoid
				whereAmI(o);

				trace("OBJECT HEIGHT: "+ oh +" HE HEIGHT:" + me_h)
				trace("OBJECT WIDTH: "+ow +" HE WIDTH:" + me_w)
				trace("OBJECT X:" + ox +" HE X:" + me_x)
				trace("OBJECT Y:" + oy +" HE Y:" + me_y)
				
				strPointY = oy;
				endPointY = oy + oh;
				strPointX = ox;
				endPointX = ox + ox;
				
				lateralMid = (strPointY + endPointY) / 2 ;
				
				trace("V Wall: s:"+ strPointY + " e:"+ endPointY)
				trace("V mid: "+ lateralMid + " HE:"+ me_y)
				
				if(severity == 1){
					trace("avoid ALL");
					//if severity is one, walk the other direction
					// 0 north 1 east 2 west 3 south
					switch(tempGoal){
						case 0:
							b.y += 60;
							tempGoal = 3;
							decideDirection(tempGoal)
							if(!b.isWalking){motor.startWalking(b);}
						break;
						case 1:
							b.x -= 60;
							tempGoal = 2;
							decideDirection(tempGoal)
							if(!b.isWalking){motor.startWalking(b);}
						break;
						case 2:
							b.x += 60;
							tempGoal = 1;
							decideDirection(tempGoal)
							if(!b.isWalking){motor.startWalking(b);}
						break;
						case 3:
							b.y -= 60;
							tempGoal = 0;
							decideDirection(tempGoal)
							if(!b.isWalking){motor.startWalking(b);}
						break;
						
					}
					
					
					
				}else if(severity == 0){
					trace("avoid - WalkAround");
					switch(tempGoal){
						
						case 1:
							b.x -= 5;
							tempGoal = 1;
							if(lateralMid > me_y){
									trace("choose top")
									decideDirection(0)
									if(!b.isWalking){motor.startWalking(b);}
									
							}
							if(me_x > ox){
								decideDirection(tempGoal)
								if(!b.isWalking){motor.startWalking(b);}
							}
						break;
						
						
					}
					
					
					
					/*if(lateralMid < me_y){
						trace("choose bottom")
						decideDirection(3)
						
						if(!b.isWalking){
							motor.startWalking(b);
						}
					}*/
					
				}
				trace("//////////////avoidObject()//END/////////////////////////")
				
				
				 /*	
				
				if(me_x < ox){
					//this.x -= 1;
		
					trace("OBJ start Y: "+ (oy));
					trace("OBJ end Y: "+ (oy + oh));
					
					
					
					point1 = new Point(ox, oy); 
					point2 = new Point(ox + ow, oy);
					point3 = new Point(ox, oy + oh);
					point4 = new Point(ox + ow, oy + oh);
				
					trace("Corners - CW tl: "+ point1)
					trace("Corners - CW tr: "+ point2)
					trace("Corners - CW bl: "+ point3)
					trace("Corners - CW br: "+ point4)
					
					body.y -= 2;
					
					
					//trace(ox + ow)
					//trace(me_x + me_w)
					//trace(oy + oh)
					//trace(me_y + me_h)
					deltaX = (ox + ow) - (me_x + me_w);
					deltaY = (oy - oh) - (me_y + me_h);
					
					//trace(deltaY > me_h)
					trace("HE: Approaching Obstacle Approx X: "+ deltaX +" , Aprox Y"+ deltaY+" from the left");
				}
				
				else if(me_x > ox + ow){
					
					this.x += 1;
					this.y -= 2;
					
					//trace(ox + ow)
					//trace(me_x + me_w)
					deltaX = (me_x + me_w) - (ox + ow);
					deltaY = (oy - oh) - (me_y + me_h);
					trace("HE: Approaching Obstacle Approx X: "+ deltaX +" , Aprox Y"+ deltaY+" from the right");
				}
				
			   
				if(me_y < oy){
					//var deltaY = oy + oh
					this.x -= 2;
					this.y += 1;
					
					
				}else if(me_y > oy){
					this.x -= 2;
					this.y -= 1;
				}
				*/
				
		}
		
		public function decideDirection(dir){
			//O_DIRECTIONS = [_n, _e, _w, _s];
			trace("//////////////decideDirection()///////////////////////////////")
			switch(dir){
				case 0: //north
					trace("North");
					_n = true;
					_e = false;
					_w = false;
					_s = false;
				break;
				
				case 1:// east
					trace("East");
					_n = false;
					_e = true;
					_w = false;
					_s = false;
				break;
				
				case 2://west
					trace("West");
					_n = false;
					_e = false;
					_w = true;
					_s = false;
				break;
				
				case 3://south
					trace("South");
					_n = false;
					_e = false;
					_w = false;
					_s = true;
				break;
					
			}
			
			trace("done deciding direction")
		
			O_DIRECTIONS[_rand] = true;
			//trace(O_DIRECTIONS[_rand]);
			trace("//////////////decideDirection()//END/////////////////////////")
			
		}
		
		
		
		//public function decideDirection(n:Number){
			
		//	mind.decideDirection(n)
	//	}
		public function compass(d:String){
			
			switch(d){
				case "reset":
					body._n = false;
					body._e = false;
					body._w = false;
					body._s = false;
				break;
				case "north":
					body._n = true;
					body._e = false;
					body._w = false;
					body._s = false;
				break;
				case "east":
					body._n = false;
					body._e = true;
					body._w = false;
					body._s = false;
				break;
				case "west":
					body._n = false;
					body._e = false;
					body._w = true;
					body._s = false;
				break;
				case "south":
					body._n = false;
					body._e = false;
					body._w = false;
					body._s = true;
				break;
				
			}
			
		}
		
		public function positioning(p:String){
			switch(p){
				case "reset":
					onLeft = false;
					onRight = false;
					onTop = false;
					onBottom = false;
				break;
				case "left":
					onLeft = true;
					onRight = false;
					onTop = false;
					onBottom = false;
				break;
				case "right":
					onLeft = false;
					onRight = true;
					onTop = false;
					onBottom = false;
				break;
				case "top":
					onLeft = false;
					onRight = false;
					onTop = true;
					onBottom = false;
				break;
				case "bottom":
					onLeft = false;
					onRight = false;
					onTop = false;
					onBottom = true;
				break;
				
			}
			
		}
		
		
		
		public function randomRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
	}
	
	
}
