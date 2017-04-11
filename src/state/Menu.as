package state
{
	import component.Maze;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	
	public class Menu extends DisplayState
	{	
		private var _layerBackground:DisplayStateLayer;
		
		public function Menu(){
			super();
		}
		override public function init():void {
			trace("menu");
			var maze:Maze = new Maze;
			_layerBackground = layers.add("maze");
			_layerBackground.addChild(maze);
		}
		override public function update():void {

		}
		override public function dispose():void {
			trace("dispose");
		}
	}
}