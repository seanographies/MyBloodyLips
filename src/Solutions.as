package  
{
	import adobe.utils.ProductManager;
	import flash.events.IMEEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.*;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Solutions extends Entity 
	{
		protected var glist:Graphiclist = new Graphiclist();
		
		//text for solutions
		protected var _s1:Text;
		protected var _s2:Text;
		protected var _s3:Text;
		protected var _s4:Text;
		protected var _s5:Text;
		
		protected var gm:GameManager = new GameManager;
		
		protected var _pressed:Boolean = false;
		
		protected var _glist:Graphiclist = new Graphiclist();
		protected var thumb_sprites:Spritemap = new Spritemap(GA.HAND_SPRITES, 128, 128);
		protected var curThumb:String = new String("default");
		protected var index_sprites:Spritemap = new Spritemap(GA.HAND_SPRITES, 128, 128);
		protected var curIndex:String = new String("default");
		protected var middle_sprites:Spritemap = new Spritemap(GA.HAND_SPRITES, 128, 128);
		protected var curMiddle:String = new String("default");
		protected var ring_sprites:Spritemap = new Spritemap(GA.HAND_SPRITES, 128, 128);
		protected var curRing:String = new String("default");
		protected var pinkie_sprites:Spritemap = new Spritemap(GA.HAND_SPRITES, 128, 128);
		protected var curPinkie:String = new String("default");
		
		protected var thumbRT:int = 0;
		protected var indexRT:int = 0;
		protected var middleRT:int = 0;
		protected var ringRT:int = 0;
		protected var pinkieRT:int = 0;
		
		protected var solutionSize:int = 30;
				
		public function Solutions() 
		{
			graphic = _glist;
			createProblem();
			layer = 1;
			if (GameManager.Splash_Screen) {
				FP.world.add(new Splash());
			}
		}
		
		override public function update():void 
		{
			super.update();
			updateControls();
			fadeOut();
		}
		
		protected function createProblem():void {
			if (GameManager.SceneTicket == 0) {
				//selects a problem and its solutions
				switch(GameManager.Problem) {
					case 0:
						addProblem("There's a hunger for it, there's a thirst for it.");
						addSolutions("Bite on it so neatly", 1);
						addSolutions("Peel the skin off", 2);
						addSolutions("Let the blood ooze out", 3);
						addSolutions("Lick it all up", 4);
						addSolutions("Continue till the pink flesh burns", 5);
						break;
					case 1:
						trace("Problem One");
						addProblem("Am I worth it?");
						addSolutions("What does she see in me?", 1);
						addSolutions("How am I better than the others?", 2);
						addSolutions("I don't think she feels the same", 3);
						addSolutions("I'm disillusioned by my fantasies ", 4);
						addSolutions("Im not good enough", 5);
						break;					
					case 2:
						trace("Problem Two");
						addProblem("There is something wrong here");
						addSolutions("I can't even read", 1);
						addSolutions("Theres too much noise going on", 2);
						addSolutions("I will never amount to anything", 3);
						addSolutions("Is there something which I missed out on?", 4);
						addSolutions("My guilt is my only motivation", 5);
						break;					
					case 3:
						trace("Problem Three");
						addProblem("This is torture, I am a cannibal");
						addSolutions("It will eventually stop", 1);
						addSolutions("It's involuntary, this will never stop", 2);
						addSolutions("I dont care if anyone sees it anymore.", 3);
						addSolutions("Im not the only one", 4);
						addSolutions("This is only the first phase", 5);
						break;					
					case 4:
						trace("Endgame Problem");
						addProblem("My Fingers are numb, the blood is dried up.");
						addSolutions("I didn't solve my problems", 1);
						addSolutions("I have to stop this", 2);
						addSolutions("To here there is no end", 3);
						addSolutions("How do they do it?", 4);
						addSolutions("There might be a better way", 5);
						break;
				}
			}
		}
		
		//creates text for problem
		protected function addProblem(_problem:String):void {
			var _pt:Text = new Text(_problem, 394, 360, { size: 35, width: 300, height: 2, wordWrap: true, align: "center" } );
			_pt.color = 0x3F1820;
			_pt.centerOO();
			_glist.add(_pt);
		}
		
		//creates text for solutions and places them to the left of the image of the corresponding finger
		protected function addSolutions(_solution:String, finger:Number):void {
			//thumb == 1/pinkie == 5
			if (finger == 1) {
				 _s1 = new Text(_solution, 200, 560, { size: solutionSize, width: 500, height: 1, wordWrap: true, color: 0x652935} );
				_glist.add(_s1);
			}
			if (finger == 2) {
				 _s2 = new Text(_solution, 304, 530, { size: solutionSize, width: 500, height: 2, wordWrap: true, color: 0x652935} );
				_glist.add(_s2);			
				}			
				if (finger == 3) {
				 _s3 = new Text(_solution, 315, 480, { size: solutionSize, width: 500, height: 2, wordWrap: true, color: 0x652935} );
				_glist.add(_s3);
				}			
				if (finger == 4) {
				 _s4 = new Text(_solution, 313, 440, { size: solutionSize, width: 500, height: 2, wordWrap: true, color: 0x652935} );
				_glist.add(_s4);
				}			
				if (finger == 5) {
				_s5  = new Text(_solution, 279, 405, { size: solutionSize, width: 500, height: 2, wordWrap: true, color: 0x652935} );
				_glist.add(_s5);
				}
		}
		
		//updates controls for solution and whites them out if the health is < 1
		protected function updateControls():void {
			if(GameManager.SceneTicket == 0){
				if (Input.pressed(Key.Q)) {
					if (GameManager.Thumb_Health > 0) {
						//solution 1 is selected, so display the thoughts for it
						GameManager.Solution = 1;
						_s1.color = 0x54786C;
						updateHealth();
						GameManager.SceneOneEnd = true;
					}else {
						_s1.color = 0x392626;
					}
				}			
				if (Input.pressed(Key.W)) {
					if (GameManager.Index_Health > 0) {
						//solution 2 is selected, so display the thoughts for it
						GameManager.Solution = 2;
						_s2.color = 0x54786C;
						updateHealth();
						GameManager.SceneOneEnd = true;
					}else {
						_s2.color = 0x392626;
					}
				}			
				if (Input.pressed(Key.E)) {
					if (GameManager.Middle_Health > 0) {
						//solution 3 is selected, so display the thoughts for it
						GameManager.Solution = 3;
						_s3.color = 0x54786C;
						updateHealth();
						GameManager.SceneOneEnd = true;
					}else {
						_s3.color = 0x392626;
					}	
				}			
				if (Input.pressed(Key.R)) {
					if (GameManager.Ring_Health > 0) {
						//solution 4 is selected, so display the thoughts for it
						GameManager.Solution = 4;
						_s4.color = 0x54786C;
						updateHealth();
						GameManager.SceneOneEnd = true;
					}else {
						_s4.color = 0x392626;
					}
				}			
				if (Input.pressed(Key.T)) {
					if (GameManager.Pinkie_Health > 0) {
						//solution 5 is selected, so display the thoughts for it
						GameManager.Solution = 5;
						_s5.color = 0x54786C;
						updateHealth();
						GameManager.SceneOneEnd = true;
					}else {
						_s5.color = 0x392626;
					}
				}
			}	
		}
		
		//heals the fingers if they are not chosen
		protected function updateHealth():void {
			if (GameManager.Solution !== 1) {
				var tt:int;
				GameManager.thumb_RT++;
				if (GameManager.Thumb_Health == 2) {
					tt = Math.floor(Math.random() * 2) + 3;
					trace("Called " +tt);
					if (GameManager.thumb_RT >= tt) {
						gm.updateFingerRegen(1);
						GameManager.Thumb_Health += 1;
						trace("Thumb health is " + GameManager.Thumb_Health);
						GameManager.thumb_RT = 0;
					}
				}				
				if (GameManager.Thumb_Health == 1) {
					tt = Math.floor(Math.random() * 2) + 4;
					trace("Called " +tt);
					if (GameManager.thumb_RT >= tt) {
						gm.updateFingerRegen(1);
						GameManager.Thumb_Health += 1;
						trace("Thumb health is " + GameManager.Thumb_Health);
						GameManager.thumb_RT = 0;
					}
				}				
				if (GameManager.Thumb_Health <= 0) {
					tt = Math.floor(Math.random() * 2) + 5;
					trace("Called " +tt);
					if (GameManager.thumb_RT >= tt) {
						gm.updateFingerRegen(1);
						GameManager.Thumb_Health += 1;
						trace("Thumb health is " + GameManager.Thumb_Health);
						GameManager.thumb_RT = 0;
					}
				}
			}			
			
			if (GameManager.Solution !== 2) {
				var it:int;
				GameManager.index_RT++;
				if (GameManager. Index_Health == 2) {
					it = Math.floor(Math.random() * 2) + 3;
					if (GameManager.index_RT >= it) {
						gm.updateFingerRegen(2);
						GameManager.Index_Health += 1;
						trace("Index health is " + GameManager.Index_Health);
						GameManager.index_RT = 0;
					}
				}				
				if (GameManager. Index_Health == 1) {
					it = Math.floor(Math.random() * 2) + 4;
					if (GameManager.index_RT >= it) {
						gm.updateFingerRegen(2);
						GameManager.Index_Health += 1;
						trace("Index health is " + GameManager.Index_Health);
						GameManager.index_RT = 0;
					}
				}				
				if (GameManager. Index_Health <= 0) {
					it = Math.floor(Math.random() * 2) + 5;
					if (GameManager.index_RT >= it) {
						gm.updateFingerRegen(2);
						GameManager.Index_Health += 1;
						trace("Index health is " + GameManager.Index_Health);
						GameManager.index_RT = 0;
					}
				}
			}			
			
			if (GameManager.Solution !== 3) {
				var mt:int;
				GameManager.middle_RT++;
				if (GameManager.Middle_Health == 2) {
					mt = Math.floor(Math.random() * 2) + 3;
					if (GameManager.middle_RT >= mt) {
						gm.updateFingerRegen(3);
						GameManager.Middle_Health += 1;
						trace("Middle health is " + GameManager.Middle_Health);
						GameManager.middle_RT = 0;
					}
				}				
				if (GameManager.Middle_Health == 1) {
					mt = Math.floor(Math.random() * 2) + 4;
					if (GameManager.middle_RT >= mt) {
						gm.updateFingerRegen(3);
						GameManager.Middle_Health += 1;
						trace("Middle health is " + GameManager.Middle_Health);
						GameManager.middle_RT = 0;
					}
				}				
				if (GameManager.Middle_Health <= 0) {
					mt = Math.floor(Math.random() * 2) + 5;
					if (GameManager.middle_RT >= mt) {
						gm.updateFingerRegen(3);
						GameManager.Middle_Health += 1;
						trace("Middle health is " + GameManager.Middle_Health);
						GameManager.middle_RT = 0;
					}
				}
			}			
			
			if (GameManager.Solution !== 4) {
				var rt:int;
				GameManager.ring_RT++;
				if (GameManager.Ring_Health < 3) {
					rt = Math.floor(Math.random() * 2) + 3;
					if (GameManager.ring_RT >= rt) {
						gm.updateFingerRegen(4);
						GameManager.Ring_Health += 1;
						trace("Ring health is " + GameManager.Ring_Health);
						GameManager.ring_RT = 0;
					}
				}				
				if (GameManager.Ring_Health < 3) {
					rt = Math.floor(Math.random() * 2) + 4;
					if (GameManager.ring_RT >= rt) {
						gm.updateFingerRegen(4);
						GameManager.Ring_Health += 1;
						trace("Ring health is " + GameManager.Ring_Health);
						GameManager.ring_RT = 0;
					}
				}				
				if (GameManager.Ring_Health < 3) {
					rt = Math.floor(Math.random() * 2) + 5;
					if (GameManager.ring_RT >= rt) {
						gm.updateFingerRegen(4);
						GameManager.Ring_Health += 1;
						trace("Ring health is " + GameManager.Ring_Health);
						GameManager.ring_RT = 0;
					}
				}
			}			
			
			if (GameManager.Solution !== 5) {
				var pt:int;
				GameManager.pinkie_RT++;
				if (GameManager.Pinkie_Health < 3) {
					pt = Math.floor(Math.random() * 2) + 3;
					if (GameManager.pinkie_RT >= pt) {
						gm.updateFingerRegen(5);
						GameManager.Pinkie_Health += 1;
						trace("Pinkie health is " + GameManager.Pinkie_Health);
						GameManager.pinkie_RT = 0;
					}
				}				
				if (GameManager.Pinkie_Health < 3) {
					pt = Math.floor(Math.random() * 2) + 4;
					if (GameManager.pinkie_RT >= pt) {
						gm.updateFingerRegen(5);
						GameManager.Pinkie_Health += 1;
						trace("Pinkie health is " + GameManager.Pinkie_Health);
						GameManager.pinkie_RT = 0;
					}
				}				
				if (GameManager.Pinkie_Health < 3) {
					pt = Math.floor(Math.random() * 2) + 5;
					if (GameManager.pinkie_RT >= pt) {
						gm.updateFingerRegen(5);
						GameManager.Pinkie_Health += 1;
						trace("Pinkie health is " + GameManager.Pinkie_Health);
						GameManager.pinkie_RT = 0;
					}
				}
			}
		}
		
		//fades out the solutions
		protected function fadeOut():void {
			if (GameManager.SceneOneEnd) {
					GameManager.SceneOne = false;
				for (var i:int = 0; i < 2; i++) 
				{
					if(_s1.alpha > 0 && !_s1.alpha == 0){
						_s1.alpha -= 0.01;
					}					if(_s2.alpha > 0){
						_s2.alpha -= 0.01;
					}					if(_s3.alpha > 0){
						_s3.alpha -= 0.01;
					}				if(_s4.alpha > 0){
						_s4.alpha -= 0.01;
					}					if(_s5.alpha > 0){
						_s5.alpha -= 0.01;
					}
					//trace("FADE OUT");
					//trace(_spritemap.alpha);
				}
				
				if (_s1.alpha == 0) {
					GameManager.SceneOneEnd = false;
					//trace("KILL");
					_pressed = false;
					//trace("FADE OUT STOP");
					FP.world.remove(this);
					GameManager.SceneTicket++;
					trace("Scene Ticket is " + GameManager.SceneTicket);
					trace("The solution is " + GameManager.Solution);
					gm.changeScene();
				}
			}
		}
		
		
	}
}