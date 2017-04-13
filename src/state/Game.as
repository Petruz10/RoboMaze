package state
{
	import component.Maze;
	
	import entity.Robot;
	
	import game.Singleplayer;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;

	public class Game extends DisplayState
	{
		private var m_layer:DisplayStateLayer;
		private var m_robot:Robot;
		private var m_maze:Maze;
		//private var m_testSinglePlayer:Singleplayer;
		
		public function Game()
		{
			super();
			trace("game konstruktor");
		}
		
		override public function init():void
		{
			//trace("game1");
			initLayers();
		//	m_testSinglePlayer = new Singleplayer();
			
		}
		
		override public function update():void
		{
			hit();
		}
		
		override public function dispose():void
		{
			
		}
		
		private function initLayers():void
		{
			m_layer = layers.add("bakground_test_layer");
			
			m_robot = new Robot();
			m_maze = new Maze();
			m_maze.x = 50;
			m_maze.y = 50;
			
			
			m_layer.addChild(m_maze);
			m_layer.addChild(m_robot);
			
			//trace(m_robot.hitTestObject(m_maze));
		
		}
		
		private function hit():void
		{
			trace(m_robot.hitTestObject(m_maze));
		}
		
		protected function addMaze(players:int):void
		{
			
		}
	}
}