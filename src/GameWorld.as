package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class GameWorld extends World 
	{
		
		protected var background:Image;
		[Embed(source = "../assets/fcFont.ttf", fontName = "Custom", mimeType = "application/x-font-truetype",fontWeight="normal", fontStyle="normal", advancedAntiAliasing="true", embedAsCFF="false")] protected static const CUSTOM_FONT:Class;
		
		public function GameWorld() 
		{
			super();
			Text.font = "custom";
		}
		
		override public function begin():void {
			super.begin();
			add(new Hand());
			add(new Solutions());
			add(new Mouth);
			add(new MusicPlayer);
			changeBackground();
		}
		
		protected function changeBackground():void {
			if (GameManager.SceneTicket == 0 || GameManager.SceneTicket == 1) {
				background = new Image(GA.ROOM_BG);
			}
			
			var e:Entity = new Entity;
			e.graphic = background;
			e.layer = GC.BACKGROUND;
			add(e);
		}
		
		
		
	}

}