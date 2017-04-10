package state
{
	import se.lnu.stickossdk.display.DisplayState;
	
	public class Credits extends DisplayState
	{
		public function Credits(){
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