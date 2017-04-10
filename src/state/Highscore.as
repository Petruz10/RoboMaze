package state
{
	import se.lnu.stickossdk.display.DisplayState;
	
	public class Highscore extends DisplayState
	{
		public function Highscore(){
			super();
		}
		override public function init():void {
			trace("highscore");
		}
		override public function update():void {
			
		}
		override public function dispose():void {
			trace("dispose");
		}
	}
}