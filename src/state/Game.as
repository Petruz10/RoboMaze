package state
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import component.Maze;
	
	import entity.Robot;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.util.ObjectUtils;

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
			if(m_maze2) m_layer.addChild(m_maze2);
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
			trace(m_maze);
			
		//	var b:DisplayObject;
			
			getChildren();
			
			if(m_players == 2) 
			{
				m_maze2 = m_maze;
				//trace("b: ", b);
				//m_maze2 = m_maze;
				m_maze2.x = 425;
			}
						
		}
		
		protected function addAvatar(Avatar:Robot):void
		{
			m_robot = Avatar;
			trace(m_robot);
		}
	}
}