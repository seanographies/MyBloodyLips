package  
{
	/**
	 * ...
	 * @author sean singh
	 */
		import net.flashpunk.FP;
		import net.flashpunk.Sfx;
		import net.flashpunk.World;
		
	public class GameManager 
	{
		public static var SceneOne:Boolean = true;
		public static var SceneOneEnd:Boolean = false;
		public static var Problem:Number = 0;
		public static var Solution:Number = 0;
		public static var Thoughts:Number = 0;
		
		public static var SceneTicket:Number = 0;
		
		public static var Splash_Screen:Boolean = true;
		
		public static var Anxiety:Number = 11;
		
		public static var IntroScene:Boolean = true;
		
		//health for the fingers
		public static var Thumb_Health:Number = 3;
		public static var Index_Health:Number = 3;
		public static var Middle_Health:Number = 3;
		public static var Ring_Health:Number = 3;
		public static var Pinkie_Health:Number = 3;
		
		//recovery values for the fingers
		public static var Thumb_Recover:Number = 0;
		public static var Index_Recover:Number = 0;
		public static var Middle_Recover:Number = 0;
		public static var Ring_Recover:Number = 0;
		public static var Pinkie_Recover:Number = 0;
		
		//regen health tickets
		public static var thumb_RT:int = 0;
		public static var index_RT:int = 0;
		public static var middle_RT:int = 0;
		public static var ring_RT:int = 0;
		public static var pinkie_RT:int = 0;
		
		//mouth bites
		public static var Bites:int = 0;
		
		public static var stopMusic:Boolean = false;
		
		public function GameManager() 
		{
		}
		
		public function changeScene():void {
			switch(SceneTicket) {
				case 0:
					FP.world = new GameWorld;
					FP.world.add(new Hand);
				case 1:
					FP.world.add(new Finger);
					break;
			}
		}
		
		//handles problem changing and whether to replay a problem and endgame state
		public function changeProblem():void {
			
			if (Anxiety <= 10) {
				IntroScene = false;
			}
			
			if (IntroScene == false) {
				switch(Problem) {
					case 1:
						Anxiety +=  4;
						if (Anxiety <= 10) {
							Problem++;
							FP.world = new GameWorld();
							changeProblem();
							changeScene();
						}
						break;
					case 2:
						Anxiety += 3;
						if (Anxiety <= 5) {
							Problem++;
							FP.world = new GameWorld();
							changeProblem();
							changeScene();
						}
						break;
					case 3:
						Anxiety += 2;
						if (Anxiety <= 3) {
							Problem = 1;
							FP.world = new GameWorld();
							changeProblem();
							changeScene();
						}
					break;
				}
			}
			
			trace("Anxiety level is " + Anxiety);
		}
		
		
		/**
		 * Constructor.Determines the recovery value for the respected finger by subtracting 3 from finger health before it is regened and +1 to health
		 * @param	finger	1 = thumb to 5 = pinkie
		 */
		public function updateFingerRegen(finger:Number):void {
			var f:Number;
			var f2:Number;
			var f3:Number;
			var f4:Number;
			var f5:Number;
			//thumb
			if (finger == 1) {
				f = 3 - Thumb_Health;
				if (f > Thumb_Recover) {
					Thumb_Recover = f;
				}
			}			
			if (finger == 2) {
				f2 = 3 - Index_Health;
				if (f2 > Index_Recover) {
					Index_Recover = f2;
				}
			}			
			if (finger == 3) {
				f3 = 3 - Middle_Health;
				if (f3 > Middle_Recover) {
					Middle_Recover = f3;
				}
			}			
			if (finger == 4) {
				f4 = 3 - Ring_Health;
				if (f4 > Ring_Recover) {
					Ring_Recover = f4;
				}
			}			
			if (finger == 5) {
				f5 = 3 - Pinkie_Health;
				if (f5 > Pinkie_Recover) {
					Pinkie_Recover = f5;
				}
			}
			trace("REGEN " + Thumb_Recover);
		}
		
	}

}