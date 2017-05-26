package game
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.fx.Flicker;
	
	import component.Maze;
	import component.MultiplayerHUD;
	import entity.PowerUp;
	import entity.Robot;
	import state.Game;
	
	//------------------------------------------------------------------------
	// Public class Multiplayer
	//------------------------------------------------------------------------
	public class Multiplayer extends Game
	{
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------				
		private var m_powerUp:PowerUp;
		private var m_powerUp2:PowerUp;
		
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function Multiplayer()
		{
			super(2);
			initAvatar2();
			initAvatar();
			initMaze();
			initHUD();
			
			addPowerUp();
			
			addChildPowerupFunc = addChildPowerUp;
			placePowerupFunc = placePowerup;
		}
		
		override public function update():void
		{
			super.update();
			if(!m_robot.startGame && !m_robot2.startGame) return;
			if(m_robot.obstacle || m_robot2.obstacle) checkhitObstacle();
			super.checkBattery();
			hitPowerup();
			checkWrongSide();
			bombHUD();
		}
		
		//------------------------------------------------------------------------
		// private methods 
		//------------------------------------------------------------------------
		/**
		* Update the bomb icon i HUD
		*/
		private function bombHUD():void
		{
			if(m_robot.bomb === false) m_hud.bomb(1, false);
			else if(m_robot.bomb) m_hud.bomb(1, true);
			
			if(m_robot2.bomb === false) m_hud.bomb(2, false);
			else if(m_robot2.bomb)  m_hud.bomb(2, true);
		}
		
		/**
		* function to see if a robot walks into a obstacle "sabotage grejs"
		*/
		private function checkhitObstacle():void
		{
			if(m_robot2.obstacle) 
			{
				for(var i:uint = 0; i<m_robot2.bombs.length; i++)
				{	
					if(m_robot.hitTestObject(m_robot2.bombs[i]))
					{
						m_robot2.removeChild(m_robot2.bombs[i]);
						bombEffect(m_robot);	
					}
				}
			}
			
			if(m_robot.obstacle)
			{
				for(var j:uint = 0; j<m_robot.bombs.length; j++)
				{
					if(m_robot2.hitTestObject(m_robot.bombs[j])) 
					{
						m_robot.removeChild(m_robot.bombs[j]);
						bombEffect(m_robot2);
					}
				}
				
			}
		}
		
		/**
		* function to check if a player have wrongSide activated
		*/
		private function checkWrongSide():void
		{
			if(m_robot.activateWrongSide)
			{
				m_robot.activateWrongSide = false;
				wrongWayEffect(m_robot2);
				m_hud.wrong(1, false);				
			}
			
			if(m_robot2.activateWrongSide)
			{
				m_robot2.activateWrongSide = false;
				wrongWayEffect(m_robot);
				m_hud.wrong(2, false);
			}
		}
		
		/**
		* function to add the powerups to the stage
		*/
		private function addChildPowerUp():void
		{
			m_layer4.addChild(m_powerUp2);
			m_layer4.addChild(m_powerUp);
		}
		
		/**
		* function to remove the powerups and set timer to add new ones
		*/
		private function newPowerup():void
		{
			if(m_layer4)m_layer4.removeChildren();
			
			Session.timer.create(100, addPowerUp);
			Session.timer.create(200, placePowerup);
			Session.timer.create(7000, addChildPowerUp);
		}
		
		/**
		* randomize which powerup comes
		*/
		private function addPowerUp():void
		{
			whichPower = Math.random();
			whichPower = Math.round(whichPower);
			
			m_powerUp = new PowerUp(whichPower);
			m_powerUp2 = new PowerUp(whichPower);
		}
		
		/**
		* place the powerup on an acceptable place
		*/
		private function placePowerup():void
		{
			var r:int;
			
			r = Math.floor(Math.random() * m_availableSpace.length);
			
			m_powerUp.x = m_availableSpace[r].x;
			m_powerUp.y = m_availableSpace[r].y;
			
			m_powerUp2.placePowerup2(m_powerUp.x - 400,  m_powerUp.y);
		}
		
		/**
		* function to check if anyone gets a powerup
		*/
		private function hitPowerup():void
		{
			if(m_powerUp.hitTestObject(m_robot2.area)) 
			{
				if(m_robot2.powerUp == 1) return;
				m_robot2.powerUp ++;
				m_robotInt = 2;
				
				switch(whichPower)
				{
					case 0:
						m_robot2.bomb = true;
						break;
					
					case 1:
						m_hud.wrong(2, true);
						break;
				}
				controlWhichPowerup();
			}
			
			if(m_powerUp2.hitTestObject(m_robot.area)) 
			{
				if(m_robot.powerUp == 1) return;
				m_robot.powerUp ++;
				m_robotInt = 1;
				
				switch(whichPower)
				{
					case 0:
						m_robot.bomb = true;
						break;
					
					case 1:
						m_hud.wrong(1, true);
						break;
				}
				controlWhichPowerup();
			}
			
			if(m_powerUp.hitTestObject(m_robot2.area) || m_powerUp2.hitTestObject(m_robot.area))
			{
				super.initPowerupSound();
				newPowerup();
			}
		}
		
		/**
		* function to control which powerup the avatar have
		*/
		private function controlWhichPowerup():void
		{
			if(m_robotInt == 1) m_robot.obstacleType = whichPower;
			if(m_robotInt == 2) m_robot2.obstacleType = whichPower;
		}
		
		/**
		* function to set the robot back to normal
		*/
		private function setToFalse():void
		{
			m_robot.wrongSide = false;
			m_robot2.wrongSide = false;
			
			m_robot.activateWrongSide = false;
			m_robot2.activateWrongSide = false;
		}
		
		/**
		* function to init the wrongway effect
		*/
		private function wrongWayEffect(robot):void
		{
			super.initWrongWaySound();
			robot.wrongSide = true;
			m_flickr = new Flicker(robot.skin, 4000); 
			Session.effects.add(m_flickr);
			Session.timer.create(4000, setToFalse)
		}
				
		/**
		* init the first avatar 
		*/
		private function initAvatar():void
		{
			m_robot = new Robot(0, 2);
			
			m_robot.x = 41;
			m_robot.y = 125;
						
			super.addAvatar(m_robot);
		}
		
		/**
		* init the second avatar
		*/
		private function initAvatar2():void
		{
			m_robot2 = new Robot(1, 2);
			
			m_robot2.x = 441;
			m_robot2.y = 125;
			
			super.addMultiplayer(m_robot2);
		}
		
		/**
		* init the maze
		*/
		private function initMaze():void
		{
			m_maze = new Maze(2);
			
			m_maze.x = 20;
			m_maze.y = 100;
			
			super.addMaze(m_maze);
		}
		
		/**
		* init the HUD
		*/
		private function initHUD():void
		{
			m_hud = new MultiplayerHUD();
			
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
			disposePowerup();
		}
		
		private function disposePowerup():void
		{
			m_powerUp = null;
			m_powerUp2 = null;
		}

	}
}