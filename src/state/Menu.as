package state
{
	import se.lnu.stickossdk.display.DisplayState;
	
	public class Menu extends DisplayState
	{	
		public function Menu(){
			super();
		}
		override public function init():void {
			trace("menu");
		}
		override public function update():void {

		}
		override public function dispose():void {
			trace("dispose");
		}
	}
}