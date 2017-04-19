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
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

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
		private var m_robot2:Robot;
		
		private var m_maze:Maze;
		private var m_maze2:Maze;
		
		private var children:Array = [];
		
		private var m_players:int;
		
	//	private var shapecopy:Shape;
		
		private var duplicate:DisplayObject;
				
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
			if(m_robot2) m_layer2.addChild(m_robot2);
			
		}
		
		private function getChildren():void
		{
			for (var i:uint = 0; i < m_maze.numChildren; i++)
			{
				children.push(m_maze.getChildAt(i));
			}
			if(m_maze2)
			{
				for (var j:uint = 0; j < m_maze2.numChildren; j++)
				{
					children.push(m_maze2.getChildAt(j));
				}
			}
		}
		
		private function hitTest():void
		{	
			for (var i:int = 0; i<children.length; i++)
			{
				if(m_robot.hitTestObject(children[i])) m_robot.hit = true;
				if(m_robot2)
				{
					if(m_robot2.hitTestObject(children[i])) m_robot2.hit = true;
				}
			//	trace(m_robot2.hitTestObject(m_maze2));
			}

		}
		
		//------------------------------------------------------------------------
		// protected methods
		//------------------------------------------------------------------------
		protected function addMaze(maze:Maze):void
		{	
			m_maze = maze;

			//return m_maze;
			
			if(m_players == 2) 
			{
				//http://stackoverflow.com/questions/10436701/as3-is-it-possible-to-duplicate-a-shape-object
				/*var g:Vector.<IGraphicsData> = m_maze.graphics.readGraphicsData();
				
				m_maze2 = new Shape();
				m_maze2.graphics.drawGraphicsData(g)
				m_maze2.x = 420;
				m_maze2.y = 100;
				m_maze2.opaqueBackground = 0x333333;*/
				//duplicateDisplayObject(m_maze);
			}	
			getChildren();
		}
		
		protected function addMaze2(maze:Maze):void
		{	
			m_maze2 = maze;
			trace(m_maze2);
			
			
		}
		
		//https://www.kirupa.com/forum/showthread.php?223798-ActionScript-3-Tip-of-the-Day&p=1939827#post1939827
		public function duplicateDisplayObject(target:DisplayObject):void 
		{
			// create duplicate
			var targetClass:Class = Object(target).constructor;
			duplicate = new targetClass();
			
			// duplicate properties
			duplicate.transform = target.transform;
			duplicate.filters = target.filters;
			duplicate.cacheAsBitmap = target.cacheAsBitmap;
			duplicate.opaqueBackground = target.opaqueBackground;
			
			/*if (target.scale9Grid) {
				var rect:Rectangle = target.scale9Grid;
				// WAS Flash 9 bug where returned scale9Grid is 20x larger than assigned
				// rect.x /= 20, rect.y /= 20, rect.width /= 20, rect.height /= 20;
				duplicate.scale9Grid = rect;
			}*/
			
			duplicate.x += 400;
			duplicate.y = 100;
			
			trace("double: ", duplicate);
			trace("targetClass children: ", targetClass.numChildren);
			trace("Children maze: ", m_maze.numChildren);
			
			//return duplicate;
		}
			
		protected function addAvatar(Avatar:Robot):void
		{
			m_robot = Avatar;
			//trace(m_robot);
		}
		
		protected function addMultiplayer(robot:Robot):void
		{
			m_robot2 = robot;
		}
	}
}