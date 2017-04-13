package state
{	
	import component.Maze;
	
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
			//testMaze(); <---- places a maze and a "robot"
		}
		private function testMaze():void {
			var maze:Maze = new Maze();
			var robot:Avatar = new Avatar();
			
			robot.scaleX = 0.5;
			robot.scaleY = 0.5;
			
			robot.x = 25;
			robot.y = 25;
			_layerBackground = layers.add("maze");
			
			_layerBackground.x = 25;
			_layerBackground.y = 25;
			
			_layerBackground.addChild(maze);
			_layerBackground.addChild(robot);
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