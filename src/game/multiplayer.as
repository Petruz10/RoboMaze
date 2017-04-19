package game
{
	import component.Maze;
	
	import entity.Robot;
	
	import state.Game;
	
	public class Multiplayer extends Game
	{
		private var m_robot:Robot;
		private var m_robot2:Robot;
		
		private var m_maze:Maze;
		private var m_maze2:Maze;
		
		public function Multiplayer()
		{
			super(2);
			trace("multiplayer");
			initAvatar2();
			initAvatar();
			
			initMaze2();
			initMaze();
		}
		
		private function initAvatar():void
		{
			m_robot = new Robot(0);
			
			m_robot.scaleX = 0.35;
			m_robot.scaleY = 0.35;
			
			m_robot.x = 43;
			m_robot.y = 125;
			
			super.addAvatar(m_robot);
		}
		
		private function initAvatar2():void
		{
			m_robot2 = new Robot(1);
			
			m_robot2.scaleX = 0.35;
			m_robot2.scaleY = 0.35;
			
			m_robot2.x = 443;
			m_robot2.y = 125;
			
			super.addMultiplayer(m_robot2);
		}
		
		private function initMaze():void
		{
			m_maze = new Maze(2);
			m_maze.opaqueBackground = 0x333333;
			
			m_maze.x = 20;
			m_maze.y = 100;
			
			super.addMaze(m_maze);
		}
		
		private function initMaze2():void
		{
			m_maze2 = new Maze(2);
			m_maze2.opaqueBackground = 0x333333;
			
			m_maze2.x = 420;
			m_maze2.y = 100;
			
			super.addMaze2(m_maze2);
		}

	}
}