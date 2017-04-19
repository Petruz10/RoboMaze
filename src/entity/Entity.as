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
			//trace("update");
		}
		
		override public function dispose():void
		{
			
		}
		
		protected function place(skin):void
		{
			skin.x = randomNumberBetween(25, 750);
			skin.y = randomNumberBetween(100, 500);			
		}
		
		private function randomNumberBetween(min:Number, max:Number):Number 
		{
			return (Math.floor(Math.random() * (max - min + 1)) + min);
		}
	}
}