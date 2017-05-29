package entity
{
	//------------------------------------------------------------------------
	// 	Flash
	//------------------------------------------------------------------------
	import flash.display.MovieClip;
	//------------------------------------------------------------------------
	// 	Project Imports
	//------------------------------------------------------------------------
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	//------------------------------------------------------------------------
	// 
	//	ENTITY - SUPER CLASS
	//
	//------------------------------------------------------------------------
	public class Entity extends DisplayStateLayerSprite
	{
		//------------------------------------------------------------------------
		// 	protected properties
		//------------------------------------------------------------------------
		protected var _skin:MovieClip;
		//------------------------------------------------------------------------
		// 	Constructor
		//------------------------------------------------------------------------
		public function Entity(){
			
		}
		//------------------------------------------------------------------------
		// override methods
		//------------------------------------------------------------------------
		override public function init():void {
			
		}
		override public function dispose():void {
			disposeSkin();
		}
		//------------------------------------------------------------------------
		// protected methods
		//------------------------------------------------------------------------
		/**
		* function to get a random x and y position
		*/
		protected function place(skin):void
		{
			skin.x = randomNumberBetween(25, 700);
			skin.y = randomNumberBetween(100, 600);			
		}
		
		//------------------------------------------------------------------------
		// private methods
		//------------------------------------------------------------------------
		/**
		* function to get a random number
		*/
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