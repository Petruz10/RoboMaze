package state
{	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	import state.Game;
	
	public class Menu extends DisplayState
	{	
		private var _layerBackground:DisplayStateLayer;
		
		public function Menu(){
			//super();
			trace("konstruktor menu");
		}
		override public function init():void {
			trace("init menu");
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