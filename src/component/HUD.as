package component
{
	import flash.text.TextField;
	
	import entity.Battery;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import flash.display.MovieClip;

	/*
	*
	* component shown right on screen 
	* super class
	* 
	*/ 
	public class HUD extends DisplayStateLayer {
		/*
		* Battery representation
		*/
		protected var battery:Battery;
		/*
		* current higscore #1
		*/
		protected var highscore:int;
		/*
		* Visual representation of highscore
		*/
		protected var highscoreField:TextField;
		/*
		* game score
		*/
		protected var points:int;
		/*
		* Visual representation of game score
		*/
		protected var pointsField:TextField
		//------------------------------------------------------------------------
		// Constructor
		//------------------------------------------------------------------------
		public function HUD() {
			super();
			init();
		}
		//------------------------------------------------------------------------
		// init HUD
		//------------------------------------------------------------------------
		private function init():void {
			points = 0;
		}
		//------------------------------------------------------------------------
		// get game score
		//------------------------------------------------------------------------
		public function get score():int {
			return points;
		}
		//------------------------------------------------------------------------
		// on update
		//------------------------------------------------------------------------
		public function set score(currentPoints:int):void {
			points = currentPoints;
		}
	}
}