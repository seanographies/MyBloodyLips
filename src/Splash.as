package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Splash extends Entity 
	{
		protected var _image:Image = new Image(GA.SPLASH_SCREEN);
		
		protected var fade_in:Boolean = true;
		protected var _timerStart:Boolean = false;
		
		protected var counter:Number = 0;
		public function Splash() 
		{
			super(x, y);
			_image.alpha = 0;
			graphic = _image;
			layer = 0;
		}
		
		
		override public function update():void 
		{
			super.update();
			fadeIn();
			fadeTimer();
			fadeOut();
		}
		
		protected function fadeTimer():void {
			if (_timerStart) {
				counter++;
				if (counter >= 140) {
					fade_in = false;
					_timerStart = false;
					counter = 0;
				}
			}
		}
		
		protected function fadeIn():void {
			if (fade_in && _image.alpha<1) {
				for (var i:int = 0; i < 2; i++) {
					_image.alpha += 0.01;
				}
			}
			if (_image.alpha == 1) {
				_timerStart = true;
			}
		}
		
		protected function fadeOut():void {
			if (!fade_in) {
				for (var i:int = 0; i < 2; i++) {
					_image.alpha -= 0.01;
				}
				if (_image.alpha == 0) {
					GameManager.Splash_Screen = false;
					FP.world.remove(this);
				}
			}
		}
		
	}

}