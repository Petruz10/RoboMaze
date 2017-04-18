package state
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	
	import component.Maze;
	import entity.Robot;
	
	import game.Singleplayer;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;

	//------------------------------------------------------------------------
	// Public class Game
	//------------------------------------------------------------------------
	public class Game extends DisplayState
	{
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		private var m_layer:DisplayStateLayer;
		private var m_layer2:DisplayStateLayer;
		private var m_robot:Robot;
		private var m_maze:Maze;
		//private var m_testSinglePlayer:Singleplayer;
		
		private var children:Array = [];
		
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function Game()
		{
			super();
			trace("game konstruktor");
		}
		
		//------------------------------------------------------------------------
		// public methods
		//------------------------------------------------------------------------
		override public function init():void
		{
			initLayers();
		}
		
		override public function update():void
		{
			hitTest();
		}
		
		override public function dispose():void
		{
			
		}
		
		//------------------------------------------------------------------------
		// private methods
		//------------------------------------------------------------------------
		private function initLayers():void
		{	
			m_layer = layers.add("bakground_test_layer");
			m_layer2 = layers.add("robot lager");
			
			m_robot = new Robot();

			m_robot.scaleX = 0.4;
			m_robot.scaleY = 0.4;
			m_robot.x = 55;
			m_robot.y = 55;
			
			m_maze = new Maze(1);
			m_maze.opaqueBackground = 0x333333;
			
			m_maze.x = 25;
			m_maze.y = 25;
			
			m_layer.addChild(m_maze);
			m_layer2.addChild(m_robot);
			
			/*
			* eventuellt skippa holder!!
			*/
			
			for (var i:uint = 0; i < m_maze.numChildren; i++)
			{
				children.push(m_maze.getChildAt(i));
			}
				
		}
		
		private function hitTest():void
		{	
			
			for (var i:int = 0; i<children.length; i++)
			{
				
				if(m_robot.hitTestObject(children[i]))
				{
					m_robot.hit = true;
				}
				//else m_robot.hit = false;
			}

		}
		
		//------------------------------------------------------------------------
		// protected methods
		//------------------------------------------------------------------------
		protected function addMaze(players:int):void
		{	
			
		}
	}
}