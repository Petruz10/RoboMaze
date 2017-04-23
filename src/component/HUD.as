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
		protected var _battery:Battery_mc;
		/*
		* current higscore #1
		*/
		protected var _highscore:int;
		/*
		* Visual representation of highscore
		*/
		protected var _highscoreField:TextField;
		/*
		* game score measured in time.
		*/
		protected var _points:int;
		/*
		* Visual representation of game score
		*/
		protected var _pointsField:TextField
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