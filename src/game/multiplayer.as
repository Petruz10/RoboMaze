package game
{
	import component.Maze;
	
	import entity.Robot;
	
	import state.Game;
	
	public class Multiplayer extends Game
	{
		private var m_robot:Robot;
		private var m_maze:Maze;
		
		public function Multiplayer()
		{
			super(2);
			trace("multiplayer");
			initAvatar();
			initMaze();
		}
		
		private function initAvatar():void
		{
			m_robot = new Robot();
			
			m_robot.scaleX = 0.35;
			m_robot.scaleY = 0.35;
			
			m_robot.x = 43;
			m_robot.y = 125;
			
			super.addAvatar(m_robot);
		}
		
		private function initMaze():void
		{
			m_maze = new Maze(2);
			m_maze.opaqueBackground = 0x333333;
			
			m_maze.x = 20;
			m_maze.y = 100;
			
			super.addMaze(m_maze);
		}

	}
}