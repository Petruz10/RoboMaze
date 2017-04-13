package entity
{
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;

	public class Entity extends DisplayStateLayerSprite
	{
		protected var _skin:MovieClip;
		protected var x:int;
		protected var y:int;
		
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
		
		protected function place():void
		{
			
		}
	}
}