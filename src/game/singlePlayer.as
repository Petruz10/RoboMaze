package game
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import component.Maze;
	import entity.Robot;	
	import state.Game;

	//------------------------------------------------------------------------
	// Public class Singleplayer
	//------------------------------------------------------------------------
	public class Singleplayer extends Game
	{
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		private var m_robot:Robot;
		private var m_maze:Maze;
		
		public function Singleplayer()
		{
			super(1);
			trace("singleplayer");

			initMaze();
			initAvatar();
		}
		
		//------------------------------------------------------------------------
		// private methods 
		//------------------------------------------------------------------------
		private function initAvatar():void
		{
			m_robot = new Robot(0);
			
			m_robot.scaleX = 0.35;
			m_robot.scaleY = 0.35;
			
			m_robot.x = 43;
			m_robot.y = 125;
			
			super.addAvatar(m_robot);
		}
		
		private function initMaze():void
		{
			m_maze = new Maze(1);
			m_maze.opaqueBackground = 0x333333;
			
			m_maze.x = 20;
			m_maze.y = 100;
			
			super.addMaze(m_maze);
		}
		
		override public function dispose():void
		{
			//disposeAvatar();
			//disposeMaze(); 
		}
		
		private function disposeMaze():void
		{
			m_maze = null;
		}
		
		private function disposeAvatar():void
		{
			m_robot = null;
		}

	}
}