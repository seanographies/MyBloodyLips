package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.*;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Hand extends Entity 
	{
		protected var _glist:Graphiclist = new Graphiclist();
		protected var sprite_map:Spritemap = new Spritemap(GA.HAND_SPRITES, 128, 128);
		protected var curanimation:String = new String("default");
		
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
		
		protected var thumbf_sprites:Spritemap = new Spritemap(GA.HAND_SPRITES, 128, 128);
		protected var curThumbf:String = new String("default");
		protected var indexf_sprites:Spritemap = new Spritemap(GA.HAND_SPRITES, 128, 128);
		protected var curIndexf:String = new String("default");
		protected var middlef_sprites:Spritemap = new Spritemap(GA.HAND_SPRITES, 128, 128);
		protected var curMiddlef:String = new String("default");
		protected var ringf_sprites:Spritemap = new Spritemap(GA.HAND_SPRITES, 128, 128);
		protected var curRingf:String = new String("default");
		protected var pinkief_sprites:Spritemap = new Spritemap(GA.HAND_SPRITES, 128, 128);
		protected var curPinkief:String = new String("default");
		
		
		public function Hand() 
		{
			super(150, 500);
			addHandSprites();
			addFleshSprites();
			addSprites();
			graphic = _glist;
			layer = GC.HAND
		}
		
		override public function update():void 
		{
			super.update();
			moveHandOff();
			updateFingerDamage();
			updateRegen();
			if (GameManager.Anxiety <= 2) {
				endGame();
			}
			fingerDeath();
		}
		
		//changes problem to 4
		protected function endGame():void {
			GameManager.Problem = 4;
		}
		
		//calls endgame when all fingers health is <= 0
		protected function fingerDeath():void {
			if (GameManager.Thumb_Health <= 0 && GameManager.Index_Health <= 0 && GameManager.Middle_Health <= 0 && GameManager.Ring_Health <= 0 && GameManager.Pinkie_Health <= 0) {
				endGame();
			}
			
			if (GameManager.Problem == 4) {
				if (GameManager.Thumb_Health <= 0 && GameManager.Index_Health <= 0 && GameManager.Middle_Health <= 0 && GameManager.Ring_Health <= 0 && GameManager.Pinkie_Health <= 0) {
					FP.world.add(new Credits());
					trace("CREDITS");
				}
			}
		}
		
		//adds sprites for finger damage
		protected function addSprites():void {						
			//thumb damage
			thumb_sprites.add("default", [16], 0, false);
			thumb_sprites.add("t2", [1], 0, false);
			thumb_sprites.add("t1", [2], 0, false);
			thumb_sprites.add("t0", [3], 0, false);
			thumb_sprites.centerOO();
			thumb_sprites.scale = 2.5;
			_glist.add(thumb_sprites);
			
			//index damage
			index_sprites.add("default", [16], 0, false);
			index_sprites.add("i2", [4], 0, false);
			index_sprites.add("i1", [5], 0, false);
			index_sprites.add("i0", [6], 0, false);
			index_sprites.centerOO();
			index_sprites.scale = 2.5;
			_glist.add(index_sprites);
			
			//middle damage
			middle_sprites.add("default", [16], 0, false);
			middle_sprites.add("m2", [7], 0, false);
			middle_sprites.add("m1", [8], 0, false);
			middle_sprites.add("m0", [9], 0, false);
			middle_sprites.centerOO();
			middle_sprites.scale = 2.5;
			_glist.add(middle_sprites);
			
			//ring damage
			ring_sprites.add("default", [16], 0, false);
			ring_sprites.add("r2", [10], 0, false);
			ring_sprites.add("r1", [11], 0, false);
			ring_sprites.add("r0", [12], 0, false);
			ring_sprites.centerOO();
			ring_sprites.scale = 2.5;
			_glist.add(ring_sprites);
			
			//pinkie damage
			pinkie_sprites.add("default", [16], 0, false);
			pinkie_sprites.add("p2", [13], 0, false);
			pinkie_sprites.add("p1", [14], 0, false);
			pinkie_sprites.add("p0", [15], 0, false);
			pinkie_sprites.centerOO();
			pinkie_sprites.scale = 2.5;
			_glist.add(pinkie_sprites);		
		}
		
		//adds sprites for regen flesh
		protected function addFleshSprites():void {
			thumbf_sprites.add("default", [16], 0, false);
			thumbf_sprites.add("t1", [18], 0, false);
			thumbf_sprites.add("t2", [19], 0, false);
			thumbf_sprites.add("t3", [20], 0, false);
			thumbf_sprites.centerOO();
			thumbf_sprites.scale = 2.5;
			_glist.add(thumbf_sprites);
			
			//index damage
			indexf_sprites.add("default", [16], 0, false);
			indexf_sprites.add("i1", [21], 0, false);
			indexf_sprites.add("i2", [22], 0, false);
			indexf_sprites.add("i3", [23], 0, false);
			indexf_sprites.centerOO();
			indexf_sprites.scale = 2.5;
			_glist.add(indexf_sprites);
			
			//middle damage
			middlef_sprites.add("default", [16], 0, false);
			middlef_sprites.add("m1", [24], 0, false);
			middlef_sprites.add("m2", [25], 0, false);
			middlef_sprites.add("m3", [26], 0, false);
			middlef_sprites.centerOO();
			middlef_sprites.scale = 2.5;
			_glist.add(middlef_sprites);
			
			//ring damage
			ringf_sprites.add("default", [16], 0, false);
			ringf_sprites.add("r1", [27], 0, false);
			ringf_sprites.add("r2", [28], 0, false);
			ringf_sprites.add("r3", [29], 0, false);
			ringf_sprites.centerOO();
			ringf_sprites.scale = 2.5;
			_glist.add(ringf_sprites);
			
			//pinkie damage
			pinkief_sprites.add("default", [16], 0, false);
			pinkief_sprites.add("p1", [30], 0, false);
			pinkief_sprites.add("p2", [31], 0, false);
			pinkief_sprites.add("p3", [32], 0, false);
			pinkief_sprites.centerOO();
			pinkief_sprites.scale = 2.5;
			_glist.add(pinkief_sprites);	
		}
		
		//adds the hand sprite
		protected function addHandSprites():void {
			//view of hand
			sprite_map.add("default", [0], 0, false);
			sprite_map.scale = 2.5;
			sprite_map.centerOO();
			_glist.add(sprite_map);	
			sprite_map.play(curanimation);
		}
		
		//animation for hand moving off screen
		protected function moveHandOff():void {
			if (GameManager.SceneOneEnd) {
				this.x -= 3;
				this.y += 4;
			}
					
			if (this.x < -10 ) {
				trace("called");
				FP.world.remove(this);
			}
		}
		
		//changes finger damage sprites depending on health values
		protected function updateFingerDamage():void {
			switch(GameManager.Thumb_Health) {
				case 2:
					curThumb = "t2";
					break;
				case 1:
					curThumb = "t1";
					break;
				case 0:
					curThumb = "t0";
					break;
			}			
			
			switch(GameManager.Index_Health) {
				case 2:
					curIndex = "i2";
					break;
				case 1:
					curIndex = "i1";
					break;
				case 0:
					curIndex = "i0";
					break;
			}			
			
			switch(GameManager.Middle_Health) {
				case 2:
					curMiddle = "m2";
					break;
				case 1:
					curMiddle = "m1";
					break;
				case 0:
					curMiddle = "m0";
					break;
			}			
			
			switch(GameManager.Ring_Health) {
				case 2:
					curRing = "r2";
					break;
				case 1:
					curRing= "r1";
					break;
				case 0:
					curRing = "r0";
					break;
			}			
			
			switch(GameManager.Pinkie_Health) {
				case 2:
					curPinkie = "p2";
					break;
				case 1:
					curPinkie = "p1";
					break;
				case 0:
					curPinkie = "p0";
					break;
			}
			thumb_sprites.play(curThumb);
			index_sprites.play(curIndex);
			middle_sprites.play(curMiddle);
			ring_sprites.play(curRing);
			pinkie_sprites.play(curPinkie);
		}
		
		//updates the regen flesh sprites
		protected function updateRegen():void {
			switch(GameManager.Thumb_Recover) {
				case 1:
					curThumbf = "t1";
					break;
				case 2:
					curThumbf = "t2";
					break;
				case 3:
					curThumbf = "t3";
					break;
			}			
			switch(GameManager.Index_Recover) {
				case 1:
					curIndexf = "i1";
					break;
				case 2:
					curIndexf = "i2";
					break;
				case 3:
					curIndexf = "i3";
					break;
			}			
			switch(GameManager.Middle_Recover) {
				case 1:
					curMiddlef = "m1";
					break;
				case 2:
					curMiddlef = "m2";
					break;
				case 3:
					curMiddlef = "m3";
					break;
			}			
			switch(GameManager.Ring_Recover) {
				case 1:
					curRingf = "r1";
					break;
				case 2:
					curRingf = "r2";
					break;
				case 3:
					curRingf = "r3";
					break;
			}			
			switch(GameManager.Pinkie_Recover) {
				case 1:
					curPinkief = "p1";
					break;
				case 2:
					curPinkief = "p2";
					break;
				case 3:
					curPinkief = "p3";
					break;
			}
			thumbf_sprites.play(curThumbf);
			indexf_sprites.play(curIndexf);
			middlef_sprites.play(curMiddlef);
			ringf_sprites.play(curRingf);
			pinkief_sprites.play(curPinkief);
		}
		
		
	}

}