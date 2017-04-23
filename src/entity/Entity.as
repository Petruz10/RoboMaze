package entity
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	//------------------------------------------------------------------------
	// public class Entity
	//------------------------------------------------------------------------
	public class Entity extends DisplayStateLayerSprite
	{
		//------------------------------------------------------------------------
		// protected properties
		//------------------------------------------------------------------------
		protected var _skin:MovieClip;
		
		public function Entity()
		{
			
		}
		
		//------------------------------------------------------------------------
		// override methods
		//------------------------------------------------------------------------
		override public function init():void
		{
			
		}
		
		override public function dispose():void
		{
			disposeSkin();
		}
		
		//------------------------------------------------------------------------
		// protected methods
		//------------------------------------------------------------------------
		protected function place(skin):void
		{
			skin.x = randomNumberBetween(25, 650);
			skin.y = randomNumberBetween(100, 600);			
		}
		
		//------------------------------------------------------------------------
		// private methods
		//------------------------------------------------------------------------
		private function randomNumberBetween(min:Number, max:Number):Number 
		{
			return (Math.floor(Math.random() * (max - min + 1)) + min);
		}
		
		//------------------------------------------------------------------------
		// dispose methods
		//------------------------------------------------------------------------
		private function disposeSkin():void
		{
			_skin = null;
		}
	}
}