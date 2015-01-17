package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class MusicPlayer extends Entity 
	{
		protected var problem1_music:Sfx = new Sfx(GA.PROBLEM1_MUSIC);
		protected var problem2_music:Sfx = new Sfx(GA.PROBLEM2_MUSIC);
		protected var problem3_music:Sfx = new Sfx(GA.PROBLEM3_MUSIC);
		protected var intro_music:Sfx = new Sfx(GA.INTRO_MUSIC);
		protected var end_music:Sfx = new Sfx(GA.END_MUSIC);
		
		public function MusicPlayer() 
		{
			playMusic();
		}
		
		override public function update():void 
		{
			super.update();
			stopMusic();
		}
		
		public function playMusic():void {
			if (GameManager.Problem == 0) {
				GameManager.stopMusic = false;
				intro_music.loop(.2);
			}			if (GameManager.Problem == 1) {
				GameManager.stopMusic = false;
				problem1_music.loop(.1);
			}			if (GameManager.Problem == 2) {
				GameManager.stopMusic = false;
				problem2_music.loop(.2);
			}			if (GameManager.Problem == 3) {
				GameManager.stopMusic = false;
				problem3_music.loop(.2);
			}			if (GameManager.Problem == 4) {
				GameManager.stopMusic = false;
				end_music.loop(.2);
			}
		}
		
		public function stopMusic():void {
			if (GameManager.Problem !== 0 || GameManager.stopMusic) {
				intro_music.stop();
			}			if (GameManager.Problem !== 1 || GameManager.stopMusic) {
				problem1_music.stop();
			}			if (GameManager.Problem !== 2 || GameManager.stopMusic) {
				problem2_music.stop();
			}			if (GameManager.Problem !== 3 || GameManager.stopMusic) {
				problem3_music.stop();
			}			if (GameManager.Problem !== 4 || GameManager.stopMusic) {
				end_music.stop();
			}
		}
		
	}

}