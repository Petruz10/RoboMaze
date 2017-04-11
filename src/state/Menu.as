package state
{
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	import state.Game;
	
	public class Menu extends DisplayState
	{	
		public function Menu(){
			//super();
			trace("konstruktor menu");
		}
		override public function init():void {
			trace("menu1");
		}
		
		override public function update():void 
		{
			//trace("Update Menu");
			//super.update();
			updateControls();
			
		}
		override public function dispose():void {
			trace("dispose menu");
		}
		
		private function updateControls():void
		{
			if(Input.keyboard.justPressed("SPACE") == true)
			{
				Session.application.displayState = new Game;
			}
		}
	}
}