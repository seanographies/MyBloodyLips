package  
{
	import flash.events.TextEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author sean singh
	 */
	public class Thoughts extends Entity 
	{
		public var _t:Text;
		public function Thoughts() 
		{
			super(230, 325);
		}
		
		public function setText(_text:String):void {
			_t = new Text(_text, 0, 0, { size: 35, width: 350, height: 1, wordWrap: true, color: 0x3F1820} );
			graphic = _t;
		}
		
	}

}