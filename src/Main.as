package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Main extends Engine
	{
		
		public function Main():void 
		{
			super(800, 600);
		}
		
		override public function init():void {
			super.init();
			FP.screen.color = 0x000000;
			//FP.console.enable();
			FP.world = new GameWorld();
		}
		
	}
	
}