package game
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import component.Maze;
	import component.MultiplayerHUD;
	
	import entity.PowerUp;
	import entity.Robot;
	
	import se.lnu.stickossdk.system.Session;
	
	import state.Game;
	
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
		
		private var m_hud:MultiplayerHUD;
		
		private var m_superPower:PowerUp;
		private var m_superPower2:PowerUp;
		
		public function Multiplayer()
		{
			super(2);
			initAvatar2();
			initAvatar();
			initMaze();
			initHUD();
			
			superPower();
		}
				
		//------------------------------------------------------------------------
		// private methods 
		//------------------------------------------------------------------------
		/*
		* init the first avatar 
		*/
		private function initAvatar():void
		{
			m_robot = new Robot(0);
			
			m_robot.x = 41;
			m_robot.y = 125;
						
			super.addAvatar(m_robot);
		}
		
		/*
		* init the second avatar
		*/
		private function initAvatar2():void
		{
			m_robot2 = new Robot(1);
			
			m_robot2.x = 441;
			m_robot2.y = 125;
			
			super.addMultiplayer(m_robot2);
		}
		
		/*
		* init the maze
		*/
		private function initMaze():void
		{
			m_maze = new Maze(2);
			
			m_maze.x = 20;
			m_maze.y = 100;
			
			super.addMaze(m_maze);
		}
		
		/*
		* init the HUD
		*/
		private function initHUD():void
		{
			m_hud = new MultiplayerHUD();
			
			m_hud.x = 0;
			m_hud.y = 0;
			
			super.addHUD(m_hud);
		}
		
		/*
		* init the superpower
		*/
		private function superPower():void
		{	
			super.addPowerUp();
		}
		
		//------------------------------------------------------------------------
		// dispose methods 
		//------------------------------------------------------------------------
		override public function dispose():void
		{
			disposeAvatar();
			disposeMaze();
			disposeHUD();
			disposePowerup();
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
			trace("dispose maze");
		}
		
		private function disposeHUD():void
		{
			m_hud = null;
			trace("dispose hud");
		}
		
		private function disposePowerup():void
		{
			m_superPower = null;
			m_superPower2 = null;
		}

	}
}