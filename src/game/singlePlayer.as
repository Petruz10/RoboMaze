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
	
	import se.lnu.stickossdk.system.Session;


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
		private var m_hud:SingleplayerHUD;
		
		private var m_min:int = 0;
		private var m_sek:Number = 0;	
		private var m_gameTime:Number = 0;
		private var m_time:String;
		
		protected var _score:Number = 0;
		
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function Singleplayer()
		{
			super(1);

			initMaze();
			initAvatar();
			initHUD();
			
			timerFunc = updateTimer;
			highscore = initHighScore;			
		}
		
		override public function update():void
		{
			super.update();
			updateHUDTime();
		}
		
		private function updateHUDTime():void
		{
			m_hud.time = m_time;
		}
		
		private function initTimer():void
		{
			Session.timer.create(1, updateTimer);
		}
		
		/*
		* function to update the timer and make it into real time,
		* also sends the info to HUD
		*/
		private function updateTimer():void
		{
			super.checkBattery();
			
			var hundraSek:Number;
			var min:String;
			var sek:String;
			var hundranull:String;
			
			_score += 1.666666666666667;
			//_score = score;
			
			m_gameTime += 1.666666666666667;
			hundraSek = Math.floor(m_gameTime);
			
			if(hundraSek == 98)
			{
				m_sek++; 
				m_gameTime = 0;
				
				if(m_sek == 40) super.initBomb();
				
				if(m_sek == 60)
				{
					m_sek = 0;
					m_min ++;
				}
			}
			
			if(m_min < 10) min = "0"+ m_min;
			else min = m_min.toString();
			
			if(m_sek < 10) sek = "0" + m_sek;
			else sek = m_sek.toString();
			
			if(hundraSek < 10) hundranull = "0" + hundraSek;
			else hundranull = hundraSek.toString();
			
			m_time = min+":"+ sek + ":" + hundranull;
		}
		
		/*
		* function to init the highscore
		*/
		public function initHighScore():void
		{
			var table:int = 1;
			var scores:int = _score;
			var range:int = 10;
						
			Session.highscore.smartSend(table, scores, range, gameOver);
		}
		
		/*
		* function to set a timer before the gameover screen shows
		*/
		protected function gameOver(e):void
		{
			Session.timer.create(1300, super.initGameOver);
		}
		
		//------------------------------------------------------------------------
		// private methods 
		//------------------------------------------------------------------------
		/*
		* init the tha avatar
		*/
		private function initAvatar():void
		{
			m_robot = new Robot(0);
			
			m_robot.x = 43;
			m_robot.y = 125;
				
			super.addAvatar(m_robot);
		}
		
		/*
		* init the maze
		*/
		private function initMaze():void
		{
			m_maze = new Maze(1);
			
			m_maze.x = 20;
			m_maze.y = 100;
			
			super.addMaze(m_maze);
		}
		
		/*
		* init the HUD
		*/
		private function initHUD():void
		{
			m_hud = new SingleplayerHUD();
			
			m_hud.x = 0;
			m_hud.y = 0;
			
			super.addHUD(m_hud);
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