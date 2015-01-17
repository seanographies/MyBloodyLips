package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Credits extends Entity 
	{
		protected var _image:Image = new Image(GA.CREDITS);
		
		public function Credits() 
		{
			graphic = _image;
			layer = 0;
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}

}