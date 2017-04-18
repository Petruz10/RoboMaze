package state
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------

	import flash.display.IGraphicsData;
	import flash.display.Shape;
	
	import component.Maze;
	import entity.Robot;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;

//	import flash.display.MovieClip;

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
		private var m_maze2:Maze;
		//private var m_testSinglePlayer:Singleplayer;
		
		private var children:Array = [];
		
		private var m_players:int;
		
		private var shapecopy:Shape;
				
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function Game(players:int)
		{
			m_players = players;
			trace("game konstruktor");
			trace("players: " + players);
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
			m_layer = layers.add("maze layer");
			m_layer2 = layers.add("robot layer");
			
			if(m_maze) m_layer.addChild(m_maze);
			if(shapecopy) m_layer.addChild(shapecopy);
			if(m_robot) m_layer2.addChild(m_robot);	
			
		}
		
		private function getChildren():void
		{
			for (var i:uint = 0; i < m_maze.numChildren; i++)
			{
				children.push(m_maze.getChildAt(i));
			}
		}
		
		private function hitTest():void
		{	
			for (var i:int = 0; i<children.length; i++)
			{
				if(m_robot.hitTestObject(children[i])) m_robot.hit = true;
			}

		}
		
		//------------------------------------------------------------------------
		// protected methods
		//------------------------------------------------------------------------
		protected function addMaze(maze:Maze):void
		{	
			m_maze = maze;

			getChildren();
			
			if(m_players == 2) 
			{
				//http://stackoverflow.com/questions/10436701/as3-is-it-possible-to-duplicate-a-shape-object
				var g:Vector.<IGraphicsData> = m_maze.graphics.readGraphicsData();
				
				shapecopy = new Shape();
				shapecopy.graphics.drawGraphicsData(g)
				shapecopy.x = 420;
				shapecopy.y = 100;
				shapecopy.opaqueBackground = 0x333333;
				trace(shapecopy);
			}
						
		}
			
		protected function addAvatar(Avatar:Robot):void
		{
			m_robot = Avatar;
			trace(m_robot);
		}
	}
}