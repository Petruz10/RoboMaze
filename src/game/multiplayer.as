package game
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import component.HUD;
	import component.Maze;
	import component.MultiplayerHUD;
	
	import entity.Robot;
	
	import state.Game;
	import entity.PowerUp;
	
	//------------------------------------------------------------------------
	// Public class Multiplayer
	//------------------------------------------------------------------------
	public class Multiplayer extends Game
	{
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		private var m_robot:Robot;
		private var m_robot2:Robot;
		
		private var m_maze:Maze;
		private var m_maze2:Maze;
		
		private var m_hud:MultiplayerHUD;
		
		private var m_superPower:PowerUp;
		private var m_superPower2:PowerUp;
		
		public function Multiplayer()
		{
			super(2);
			trace("multiplayer");
			initAvatar2();
			initAvatar();
			
			initMaze2();
			initMaze();
			
			initHUD();
			
			superPower();
		}
				
		//------------------------------------------------------------------------
		// private methods 
		//------------------------------------------------------------------------
		private function initAvatar():void
		{
			m_robot = new Robot(0);
			
			m_robot.x = 41;
			m_robot.y = 125;
						
			super.addAvatar(m_robot);
		}
		
		private function initAvatar2():void
		{
			m_robot2 = new Robot(1);
			
			m_robot2.x = 441;
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
		
		private function initHUD():void
		{
			m_hud = new MultiplayerHUD();
			
			m_hud.x = 0;
			m_hud.y=0;
			
			super.addHUD(m_hud);
		}
		
		private function superPower():void
		{
			m_superPower = new PowerUp();
			m_superPower2 = new PowerUp();
			
			super.addPowerUp(m_superPower, m_superPower2);
			trace("Robot 1", m_robot.x);
			trace("Robot 2", m_robot2.x);
		}
		
		//------------------------------------------------------------------------
		// dispose methods 
		//------------------------------------------------------------------------
		override public function dispose():void
		{
			disposeAvatar();
			disposeMaze();
			disposeHUD();
		}
		
		private function disposeAvatar():void
		{
			m_robot = null;
			m_robot2 = null;
			trace("dispose Avatar");
		}
		
		private function disposeMaze():void
		{
			m_maze = null;
			m_maze2 = null;
			trace("dispose maze");
		}
		
		private function disposeHUD():void
		{
			m_hud = null;
			trace("dispose hud");
		}

	}
}