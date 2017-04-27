package game
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import component.HUD;
	import component.Maze;
	
	import entity.Robot;
	
	import state.Game;
	import component.SingleplayerHUD;

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
		private var m_hud:HUD;
		
		public function Singleplayer()
		{
			super(1);

			initMaze();
			initAvatar();
			initHUD();
		}
		
		//------------------------------------------------------------------------
		// private methods 
		//------------------------------------------------------------------------
		private function initAvatar():void
		{
			m_robot = new Robot(0);
			
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
		
		private function initHUD():void
		{
			m_hud = new SingleplayerHUD();
			
			m_hud.x = 0;
			m_hud.y=0;
			
			super.addHUD(m_hud);
		}
		
		override public function dispose():void
		{
			disposeAvatar();
			disposeMaze(); 
			disposeHUD();
		}
		
		private function disposeMaze():void
		{
			m_maze = null;
			trace("dispose maze");
		}
		
		private function disposeAvatar():void
		{
			m_robot = null;
			trace("dispose avatar");
		}
		
		private function disposeHUD():void
		{
			m_hud = null;
			trace("dispose hud");
		}

	}
}