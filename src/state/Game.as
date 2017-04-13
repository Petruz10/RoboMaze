package state
{
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	import component.Maze;
	
	import entity.Robot;
	
	import game.Singleplayer;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;

	public class Game extends DisplayState
	{
		private var m_layer:DisplayStateLayer;
		private var m_layer2:DisplayStateLayer;
		private var m_robot:Robot;
		private var m_maze:Maze;
		//private var m_testSinglePlayer:Singleplayer;
		
		private var children:Array = [];
		
		public function Game()
		{
			super();
			trace("game konstruktor");
		}
		
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
		
		private function initLayers():void
		{	
			m_layer = layers.add("bakground_test_layer");
			m_layer2 = layers.add("robot lager");
			
			m_robot = new Robot();
			m_robot.opaqueBackground = 0xFFFFFF;
			
			m_robot.x = 100;
			m_robot.y = 100;
			
			m_maze = new Maze();
			m_maze.opaqueBackground = 0xFF2200;
			
			//m_maze.holder.opaqueBackground = 0xFFFFFF;
			
			m_maze.x = 50;
			m_maze.y = 50;
			
			m_layer.addChild(m_maze);
			m_layer2.addChild(m_robot);
			
			
			
			for (var i:uint = 0; i < m_maze.holder.numChildren; i++)
			{
				children.push(m_maze.holder.getChildAt(i));
			}
				
			trace(children);
			for (var j:int = 0; j<children.length; j++)
			{
				//trace("children: " + children[j].x, children[j].y);
			}

				
		}
		
		private function hitTest():void
		{	
			//var children:Array = [];
			//trace(m_maze.holder);
		//	trace("robo coord:" + m_robot.x, m_robot.y);
			
			//loopar igenom lvl array, hitTestPoint  (4 markörer)
			
			
			for (var i:int = 0; i<children.length; i++)
			{
				//trace(m_robot.hitTestObject(children[i]));
				trace("children: " + children[i].x, children[i].y);
				trace("robot: " + m_robot.x, m_robot.y);
				trace(children[i].hitTestObject(m_robot));
			}
			
		//	trace(m_robot.x);
			
			

		}
		
		protected function addMaze(players:int):void
		{	
			
		}
	}
}