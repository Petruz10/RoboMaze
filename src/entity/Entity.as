package entity
{
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;

	public class Entity extends DisplayStateLayerSprite
	{
		protected var _skin:MovieClip;
		
		public function Entity()
		{
		}
		
		override public function init():void
		{
			
		}
		override public function update():void
		{
			trace("update");
		}
		
		override public function dispose():void
		{
			
		}
	}
}