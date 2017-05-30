package game
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import component.Maze;
	import component.SingleplayerHUD;
	
	import entity.Obstacle;
	import entity.Robot;
	
	import se.lnu.stickossdk.system.Session;
	
	import state.Game;


	//------------------------------------------------------------------------
	// Public class Singleplayer
	//------------------------------------------------------------------------
	public class Singleplayer extends Game
	{
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		private var m_min:int = 0;
		private var m_sek:Number = 0;	
		private var m_gameTime:Number = 0;
		private var m_time:String;
		
		private var m_bomb:Obstacle;
		private var m_bombs:Vector.<Obstacle> = new Vector.<Obstacle>();
		private var m_score:Number = 0;
		
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function Singleplayer()
		{
			super(1);

			initMaze();
			initAvatar();
			initHUD();
			
			initTimerfunc = initTimer;
			timerFunc = updateTimer;
			highscore = initHighScore;			
		}
		
		override public function update():void
		{
			super.update();
			updateHUDTime();
			if(m_bomb) checkhitBomb();
		}
		
		//------------------------------------------------------------------------
		// private methods 
		//------------------------------------------------------------------------
		private function updateHUDTime():void
		{
			m_hud.time = m_time;
		}
		
		/**
		* function to init a Timer that is used for the time measurment
		*/
		private function initTimer():void
		{
			Session.timer.create(1, updateTimer);
		}
		
		/**
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
			
			m_score += 1.666666666666667;
			
			m_gameTime += 1.666666666666667;
			hundraSek = Math.floor(m_gameTime);
			
			if(hundraSek == 98)
			{
				m_sek++; 
				m_gameTime = 0;
				
				if(m_sek == 40) initBomb();
				
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
		
		/**
		* function to init the bomb
		*/
		private function initBomb():void
		{
			if(m_robot.die) return;
			m_bomb = new Obstacle(0);
			m_bombs.push(m_bomb);
			
			findBombPlace();
		}
		
		/**
		 * function to find an available space for the bomb
		 */
		private function findBombPlace():void
		{
			var r:int;
			
			r = Math.floor(Math.random() * m_availableSpace.length);
			
			m_bomb.x = m_availableSpace[r].x;
			m_bomb.y = m_availableSpace[r].y;
			
			m_layer4.addChild(m_bomb);
			
			Session.timer.create(7000, initBomb);
		}
		
		/**
		 * function to check if the player walks into a bomb
		 */
		private function checkhitBomb():void
		{
			for(var i:uint = 0; i<m_bombs.length; i++)
			{
				if(m_robot.hitTestObject(m_bombs[i]))
				{
					m_layer4.removeChild(m_bombs[i]);
					super.bombEffect(m_robot);
				}
			}
		}
		
		/**
		* function to init the highscore
		*/
		private function initHighScore():void
		{
			var table:int = 1;
			var scores:Number = m_score;
			var range:int = 10;
						
			Session.highscore.smartSend(table, scores, range, gameOver);
		}
		
		/**
		* function to set a timer before the gameover screen shows
		*/
		private function gameOver(e):void
		{
			Session.timer.create(1300, super.initGameOver);
		}
		
		/**
		* init the tha avatar
		*/
		private function initAvatar():void
		{
			m_robot = new Robot(0);
			
			m_robot.x = 43;
			m_robot.y = 125;
				
			super.addAvatar(m_robot);
		}
		
		/**
		* init the maze
		*/
		private function initMaze():void
		{
			m_maze = new Maze(1);
			
			m_maze.x = 20;
			m_maze.y = 100;
			
			super.addMaze(m_maze);
		}
		
		/**
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
			super.dispose();
			disposeBombs();
		}
		
		private function disposeBombs():void
		{
			for(var i:uint = 0; i<m_bombs.length; i++)
			{
				m_bombs[i] = null;
			}
			
			m_bombs = null;
			m_bomb = null;
		}
	}
}