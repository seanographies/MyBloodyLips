package  
{
	import flash.display.Sprite;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.*;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Mouth extends Entity 
	{
		protected var _spritemap:Spritemap = new Spritemap(GA.MOUTH_SPRITES, 128, 128);
		protected var _glist:Graphiclist = new Graphiclist;
		protected var curAnimation:String;
		
		protected var _pressed:Number = 0;
		
		protected var timerStart:Boolean = false;
		protected var counter:Number = 0;
		protected var timeLimit:Number = 30;
		
		public function Mouth() 
		{
			super(390, 85);
			setHitbox(160,42, 64, 12);
			addSprites();
			updateDefaultSprites();
			graphic = _glist;
			layer = GC.BEHIND_MIRROR;
			type = "mouth";
		}
		
		override public function update():void 
		{
			super.update();
			defaultTimer();
		}
		
		protected function addSprites():void {
			_spritemap.add("default", [0], 0, false);
			_spritemap.add("default1", [12], 0, false);
			_spritemap.add("default2", [16], 0, false);
			_spritemap.add("default3", [20], 0, false);
			_spritemap.add("default4", [24], 0, false);
			_spritemap.add("default5", [28], 0, false);
			
			
			
			_spritemap.add("bite", [1, 2, 3], 12, false);
			_spritemap.add("bite1", [13, 14, 15], 12, false);
			_spritemap.add("bite2", [17, 18, 19], 12, false);
			_spritemap.add("bite3", [21, 22, 23], 12, false);
			_spritemap.add("bite4", [25, 26, 27], 12, false);
			_spritemap.add("bite5", [29, 30, 31], 12, false);
			
			_spritemap.add("lick", [4, 5, 6, 7, 8, 9, 10, 11,32,32,34,35,36,37], 4, true);
			
			_spritemap.scale = 2;
			_spritemap.centerOO();
			_spritemap.x += 12;
			_spritemap.y += 40;
			_glist.add(_spritemap);
		}
		
		protected function defaultTimer():void {
			if (timerStart) {
				counter++;
				if (counter >= timeLimit) {
					timerStart = false;
					counter = 0;
					updateDefaultSprites();
				}
			}
		}
		
		public function playBite():void {			
			switch(GameManager.Bites) {
				case 0:
					curAnimation = "bite";
					break;
				case 1:
					curAnimation = "bite1";
					break;
				case 2:
					curAnimation = "bite2";
					break;
				case 3:
					curAnimation = "bite3";
					break;
				case 4:
					curAnimation = "bite4";
					break;
				case 5:
					curAnimation = "bite5";
					break;
					
			}
			
			if (GameManager.Bites >= 5) {
				curAnimation = "bite5";
			}
			
			_spritemap.play(curAnimation);
			timerStart = true;
		}
		
		public function playLicking():void {
			curAnimation = "lick";
			_spritemap.play(curAnimation);
			GameManager.Bites = 0;
		}
		
		protected function updateDefaultSprites():void {
			switch(GameManager.Bites) {
				case 0:
					curAnimation = "default";
					break;
				case 1:
					curAnimation = "default1";
					break;
				case 2:
					curAnimation = "default2";
					break;
				case 3:
					curAnimation = "default3";
					break;
				case 4:
					curAnimation = "default4";
					break;
				case 5:
					curAnimation = "default5";
					break;
					
			}
			
			if (GameManager.Bites >= 5) {
				curAnimation = "default5";
			}
			
			_spritemap.play(curAnimation);
		}
		
		
	}

}