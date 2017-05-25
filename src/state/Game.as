
package state
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.net.SharedObject;
	
	import component.Instruction;
	import component.Maze;
	import component.MultiplayerInstruction;
	import component.SingleplayerInstruction;
	
	import entity.BatteryRefill;
	import entity.Obstacle;
	import entity.PowerUp;
	import entity.Robot;
	import entity.TestPlaceObj;
	import entity.Tile;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.fx.Flicker;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;

	//------------------------------------------------------------------------
	// Public class Game
	//------------------------------------------------------------------------
	public class Game extends DisplayState
	{
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		/*
		* some variables for the different layers
		*/
		private var m_layer:DisplayStateLayer;
		private var m_layer2:DisplayStateLayer;
		private var m_layer3:DisplayStateLayer;
		private var m_layer4:DisplayStateLayer;
		private var m_layer5:DisplayStateLayer;
	
		/*
		 * variables for powerups 
		 */
		private var m_powerUp:PowerUp;
		private var m_powerUp2:PowerUp;
		
		private var m_bomb:Obstacle;
		private var m_bombs:Vector.<Obstacle> = new Vector.<Obstacle>();
		
		/*
		* variables for the robots 
		*/
		private var m_robot:Robot;
		private var m_robot2:Robot;
		
		/*
		* maze
		*/
		private var m_maze:Maze;
		
		/*
		* the grapichal batteries
		*/
		private var m_battery:BatteryRefill;
		private var m_battery2:BatteryRefill;
		
		private var m_children:Vector.<Tile> = new Vector.<Tile>(); 
		private var m_players:int;
		private var m_hud;
		
		private var m_backgroundMusic:SoundObject;
		private var m_bombSound:SoundObject;
		private var m_wrongSound:SoundObject;
		private var m_powerupSound:SoundObject;

		private var m_SharedObjPlayers:SharedObject;
		private var m_win:SharedObject;
		
		private var m_flickr:Flicker;
		private var m_instructions:Instruction;
		
		private var startGame:Boolean= false;
						
		private var m_availableSpace:Vector.<Point> = new Vector.<Point>(); 
		private var xArray:Vector.<int> = new Vector.<int>(); 
		private var yArray:Vector.<int> = new Vector.<int>(); 
		private var m_testObj:TestPlaceObj;
		
		private var m_robotInt:int;
		
		protected var timerFunc:Function;
	
		protected var highscore:Function;
		protected var score:Number;
		
		//------------------------------------------------------------------------
		// public properties 
		//------------------------------------------------------------------------
		public var whichPower:Number;
				
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function Game(players:int)
		{
			m_players = players;
		}
		
		//------------------------------------------------------------------------
		// public methods
		//------------------------------------------------------------------------
		/*
		* the init function to start the Game state
		*/
		override public function init():void
		{
			initLayers();
			initInstructions();
			initSharedObject();			
			initTestObj();
			findPoints(); 
			initSound();
		}
		
		/*
		* ovveride of the update function which goes every frame
		*/
		override public function update():void
		{
			if(m_robot.die) return;
			switch(m_players)
			{
				case 1:
					if(!m_robot.startGame) return;
					break;
				
				case 2:
					if(!m_robot.startGame && !m_robot2.startGame) return;
					break;
			}
			
			if(!startGame) initGame();
			hitTest();
			hitBattery();
			updateHUDBattery();
			if(m_bomb) checkhitBomb();
			
			if(m_players == 2) 
			{
				hitPowerup();
				checkBattery();
				if(m_robot.obstacle || m_robot2.obstacle)checkhitObstacle();
				checkWrongSide();
				bombHUD();
			} 
		}
		
		/*
		* ovveride dispose, this function goes when the state changes
		*/
		override public function dispose():void
		{
			disposeMaze();
			disposeAvatar();
			disposeChildren();
			disposeLayers();	
			disposeBattery()
			disposeHUD();
			disposeSharedObj();
			disposeEffects();
			disposeInstructions();
			if(m_players == 2) disposePowerUps();
		}
		
		//------------------------------------------------------------------------
		// private methods
		//------------------------------------------------------------------------
		/*
		* function to show the instructions
		*/
		private function initInstructions():void
		{
			switch(m_players)
			{
				case 1: 
					m_instructions = new SingleplayerInstruction();
					break;
				
				case 2:
					m_instructions = new MultiplayerInstruction();
					break;
			}
			
			m_layer5 = layers.add("instructions");
			m_layer5.addChild(m_instructions);
		}
		
		/*
		* function to save in sharedobject if there is one or two players playing
		*/
		private function initSharedObject():void
		{
			m_SharedObjPlayers = SharedObject.getLocal("players");
			m_SharedObjPlayers.data.players = m_players;
			m_SharedObjPlayers.flush();
	
			return;
		}
		/*
		* function to init the layers
		*/
		private function initLayers():void
		{	
			m_layer = layers.add("maze layer");
			m_layer4 = layers.add("powerup layer");
			m_layer3 = layers.add("battery layer");
			m_layer2 = layers.add("robot layer");
			
			if(m_maze) m_layer.addChild(m_maze);
			if(m_robot) m_layer2.addChild(m_robot);	
			if(m_robot2) m_layer2.addChild(m_robot2);
			
			m_layer.addChild(m_hud);
		}
		
		/*
		* function to get all the childrens in the maze, aka walls
		*/
		private function getChildren():void
		{
			for (var i:uint = 0; i < m_maze.numChildren; i++)
			{
				m_children.push(m_maze.getChildAt(i));
			}
		}
		
		/*
		* instance the new testobject and add it to the stage, 
		* the object that tests if there are any spots
		*/
		private function initTestObj():void
		{
			m_testObj = new TestPlaceObj();
			m_testObj.placeObj();
			
			m_layer.addChild(m_testObj);
		}
		
		/*
		* function to fina the available spaces for the battery and powerups
		*/
		private function findPoints():void
		{
			for (var i:int = 0; i<m_children.length; i++)
			{
				if(m_players == 2)
				{
					if(m_testObj.hitTestObject(m_children[i]) || m_testObj.testObjX <= 400) m_testObj.placeObj(); 
				}
				else
				{
					if(m_testObj.hitTestObject(m_children[i])) m_testObj.placeObj(); 
				}
			}
			xArray.unshift(m_testObj.testObjX);
			yArray.unshift(m_testObj.testObjY);
			
			if(xArray.length > 2)
			{
				if(xArray[0] == xArray[1]&& yArray[0] == yArray[1]) 
				{
					m_testObj.placeObj();
					m_availableSpace.push(new Point(xArray[0], yArray[0]));
				}
			}
			
			checkLength();
		}
		
		/*
		* function to check the length of the Vector of available spaces
		*/
		private function checkLength():void
		{
			if(m_availableSpace.length < 60) findPoints();
		}
		
		/*
		* function to init the game
		*/
		private function initGame():void
		{
			m_layer5.removeChildren();
			startGame = true;
			m_robot.initBattery();
			initBattery();
			
			switch(m_players) 
			{
				case 2:
					m_robot2.initBattery();
					initBattery2();
					Session.timer.create(1600, addChildPowerUp);
					Session.timer.create(500, placePowerup);
					break;
				
				case 1:
					initTimer();
			}
			
			findBatteryPlace();
		}
		
		/*
		* function to find a random place to place out the battery/batteries
		*/
		private function findBatteryPlace():void
		{
			var r:int;

			r = Math.floor(Math.random() * m_availableSpace.length);

			m_battery.x = m_availableSpace[r].x;
			m_battery.y = m_availableSpace[r].y;
			
			addBattery();
			
			if(m_players == 2) m_battery2.placeBattery2(m_battery.x - 400,  m_battery.y);
		}
		
		/*
		* function to init a Timer that is used for the time measurment
		*/
		private function initTimer():void
		{
			Session.timer.create(1, timerFunc);
		}
		
		/*
		* function to play the background sound
		*/
		private function initSound():void
		{
			Session.sound.musicChannel.sources.add("game_bgmusic", BackgroundGame_mp3);
			m_backgroundMusic = Session.sound.musicChannel.get("game_bgmusic");
			m_backgroundMusic.volume = 0.3;
			m_backgroundMusic.play(int.MAX_VALUE); //loop av ljud "Henke hack"
		}
		
		/*
		* function to instance a new grapichal battery
		*/
		private function initBattery():void
		{
			m_battery = new BatteryRefill();
		}
		
		/*
		* function to instance a new grapichal battery
		*/
		private function initBattery2():void
		{
			m_battery2 = new BatteryRefill();
		}
		
		protected function initBomb():void
		{
			m_bomb = new Obstacle(0);
			m_bombs.push(m_bomb);
			
			findBombPlace();
		}
		
		//gör om find funktionerna för att returnera ett x och ett y värde
		private function findBombPlace():void
		{
			var r:int;
			
			r = Math.floor(Math.random() * m_availableSpace.length);
			
			m_bomb.x = m_availableSpace[r].x;
			m_bomb.y = m_availableSpace[r].y;
			
			m_layer4.addChild(m_bomb);
			
			Session.timer.create(7000, initBomb);
		}
		
		private function checkhitBomb():void
		{
			for(var i:uint = 0; i<m_bombs.length; i++)
			{
				if(m_robot.hitTestObject(m_bombs[i]))
				{
					m_layer4.removeChild(m_bombs[i]);
					bombEffect(m_robot);
				}
			}
		}
		
		private function bombEffect(robot):void
		{
			initBombSound();
			robot.speed = 0;
			
			m_flickr = new Flicker(robot.skin, 1000); //obj, tid (hur länge), intervall
			Session.effects.add(m_flickr);
			Session.timer.create(1000, initSpeed);
		}
		
		/*
		* function to see the battery level at the players,
		* and if there is none left save who won in sharedObj
		*/
		protected function checkBattery():void
		{
			m_win = SharedObject.getLocal("playerwon");
			
			if (m_players == 2) 
			{
				if(m_robot.die || m_robot2.die) return;
				
				if(m_robot.battery.HP == 0)
				{
					Session.timer.create(1100, initGameOver);
					m_win.data.won = 2;
					m_robot2.die = true;
				}
				else if(m_robot2.battery.HP == 0)
				{
					Session.timer.create(1100, initGameOver);
					m_win.data.won = 1;
					m_robot.die = true;
				}
			}
			else
			{
				if(m_robot.battery.HP > 0) initTimer();		
				if(m_robot.battery.HP == 0) 
				{
					m_robot.die = true;
					highscore();
				}
				m_win.data.won = 0;
			}
			
			m_win.flush(); 
		}
		
		private function controlWhichPowerup():void
		{
			if(m_robotInt == 1) m_robot.obstacleType = whichPower;
			if(m_robotInt == 2) m_robot2.obstacleType = whichPower;
		}
		
		private function bombHUD():void
		{
			if(m_robot.bomb === false) m_hud.bomb(1, false);
			else if(m_robot.bomb) m_hud.bomb(1, true);
						
			if(m_robot2.bomb === false) m_hud.bomb(2, false);
			else if(m_robot2.bomb)  m_hud.bomb(2, true);
		}
		
		/*
		* function to find a randomplace for the powerups
		*/
		private function placePowerup():void
		{
			var r:int;
			
			r = Math.floor(Math.random() * m_availableSpace.length);
			
			m_powerUp.x = m_availableSpace[r].x;
			m_powerUp.y = m_availableSpace[r].y;
			
			m_powerUp2.placePowerup2(m_powerUp.x - 400,  m_powerUp.y);
		}
		
		/*
		* function to add the powerups to the stage
		*/
		private function addChildPowerUp():void
		{
			m_layer4.addChild(m_powerUp2);
			m_layer4.addChild(m_powerUp);
		}
		
		/*
		* function to add the battery/batteries to tha stage
		*/
		private function addBattery():void
		{
			m_layer3.addChild(m_battery);
			if(m_battery2) m_layer3.addChild(m_battery2);
		}
		
		/*
		* function to check if the robot walks into a wall
		*/
		private function hitTest():void
		{	
			
			for (var i:int = 0; i<m_children.length; i++)
			{
				if(m_children[i].hitTestObject(m_robot.area)) m_robot.hit = true;
				if(m_robot2)
				{
					if(m_children[i].hitTestObject(m_robot2.area)) m_robot2.hit = true;
				}
			}
		}
		
		/*
		* function to see if anyone gets a battery
		*/
		private function hitBattery():void
		{
			switch(m_players)
			{
				case 2:
					if(m_battery.hitTestObject(m_robot2)) m_robot2.hitBattery = true;
					if(m_battery2.hitTestObject(m_robot)) m_robot.hitBattery = true;
					
					if(m_robot.hitBattery || m_robot2.hitBattery)
					{
						m_layer3.removeChildren();
						findBatteryPlace();
						return;
					}
					break;
				
				case 1:
					if(m_battery.hitTestObject(m_robot.area))
					{
						m_robot.hitBattery = true;
						m_layer3.removeChildren();
						findBatteryPlace();
						return;
					}
					break;		
			}
		}
		
		/*
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
				initPowerupSound();
				newPowerup();
			}
		}
		
		private function newPowerup():void
		{
			if(m_layer4)m_layer4.removeChildren();
			
			Session.timer.create(100, addPowerUp);
			Session.timer.create(200, placePowerup);
			Session.timer.create(7000, addChildPowerUp);
			
		}
		
		private function initPowerupSound():void
		{
			Session.sound.musicChannel.sources.add("powerup_sound", RobotPickUp_mp3);
			m_powerupSound = Session.sound.musicChannel.get("powerup_sound");
			m_powerupSound.volume = 0.3;
			m_powerupSound.play();
		}
		
		/*
		* function to update the battery in the HUD
		*/
		private function updateHUDBattery():void
		{
			switch(m_robot.battery.HP)
			{
				case 0:
					m_hud.battery1Lvl = m_robot.battery.HP;
					break;
				case 10:
					m_hud.battery1Lvl = m_robot.battery.HP;
					break;
				case 20:
					m_hud.battery1Lvl = m_robot.battery.HP;
					break;
				case 30:
					m_hud.battery1Lvl = m_robot.battery.HP;
					break;
				case 40:
					m_hud.battery1Lvl = m_robot.battery.HP;
					break;
				case 50:
					m_hud.battery1Lvl = m_robot.battery.HP;
					break;
				case 60:
					m_hud.battery1Lvl = m_robot.battery.HP;
					break;
				case 70:
					m_hud.battery1Lvl = m_robot.battery.HP;
					break;
				case 80:
					m_hud.battery1Lvl = m_robot.battery.HP;
					break;
				case 90:
					m_hud.battery1Lvl = m_robot.battery.HP;
					break;
				case 100:
					m_hud.battery1Lvl = m_robot.battery.HP;
					break;
			}
			
			if(m_players == 2) 
			{
				switch(m_robot2.battery.HP)
				{
					case 0:
						m_hud.battery2Lvl = m_robot2.battery.HP;
						break;
					case 10:
						m_hud.battery2Lvl = m_robot2.battery.HP;
						break;
					case 20:
						m_hud.battery2Lvl = m_robot2.battery.HP;
						break;
					case 30:
						m_hud.battery2Lvl = m_robot2.battery.HP;
						break;
					case 40:
						m_hud.battery2Lvl = m_robot2.battery.HP;
						break;
					case 50:
						m_hud.battery2Lvl = m_robot2.battery.HP;
						break;
					case 60:
						m_hud.battery2Lvl = m_robot2.battery.HP;
						break;
					case 70:
						m_hud.battery2Lvl = m_robot2.battery.HP;
						break;
					case 80:
						m_hud.battery2Lvl = m_robot2.battery.HP;
						break;
					case 90:
						m_hud.battery2Lvl = m_robot2.battery.HP;
						break;
					case 100:
						m_hud.battery2Lvl = m_robot2.battery.HP;
						break;
				}
			}
		}
		
		/*
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
		
		/*
		* för aktivering av wrongSide så fort användaren klickar på knapp 1
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
		
		private function wrongWayEffect(robot):void
		{
			initWrongWaySound();
			robot.wrongSide = true;
			m_flickr = new Flicker(robot.skin, 4000); 
			Session.effects.add(m_flickr);
			Session.timer.create(4000, setToFalse)
		}
		
		private function initWrongWaySound():void
		{
			Session.sound.musicChannel.sources.add("game_wrongSound", RobotWrongWay_mp3);
			m_wrongSound = Session.sound.musicChannel.get("game_wrongSound");
			m_wrongSound.volume = 0.5;
			m_wrongSound.play();
		}
		
		/*
		* function to play a bomb sound
		*/
		private function initBombSound():void
		{
			Session.sound.musicChannel.sources.add("game_bombSound", RobotBomb_mp3);
			m_bombSound = Session.sound.musicChannel.get("game_bombSound");
			m_bombSound.volume = 0.2;
			m_bombSound.play();
		}
		
		/*
		* function to set the speed of the robot to normal
		*/
		private function initSpeed():void
		{
			if(m_robot2) m_robot2.speed = 3;
			m_robot.speed = 3;
		}
		
		/*
		* function to set the controls to normal
		*/
		private function setToFalse():void
		{
			m_robot.wrongSide = false;
			m_robot2.wrongSide = false;
			
			m_robot.activateWrongSide = false;
			m_robot2.activateWrongSide = false;
		}
		
		/*
		* function to change the display state to GameOver
		*/
		protected function initGameOver():void
		{
			Session.application.displayState = new GameOver;
		}

		//------------------------------------------------------------------------
		// protected methods
		//------------------------------------------------------------------------
		/*
		* function to get the maze
		*/
		protected function addMaze(maze:Maze):void
		{	
			m_maze = maze;
			getChildren();
		}
		
		/*
		* function to get the first avatar
		*/
		protected function addAvatar(avatar:Robot):void
		{
			m_robot = avatar;
		}
		
		/*
		* function to get the second avatar
		*/
		protected function addMultiplayer(robot:Robot):void
		{
			m_robot2 = robot;
		}
		
		/*
		* function to get the HUD
		*/
		protected function addHUD(hud):void
		{
			m_hud = hud;
		}
		
		/*
		* function to instance a random powerup
		*/
		protected function addPowerUp():void
		{
			whichPower = Math.random();
			whichPower = Math.round(whichPower);
			
			m_powerUp = new PowerUp(whichPower);
			m_powerUp2 = new PowerUp(whichPower);
		}
		
		//------------------------------------------------------------------------
		// dispose methods
		//------------------------------------------------------------------------
		private function disposeLayers():void
		{
			m_layer.removeChildren();
			m_layer2.removeChildren();
			m_layer3.removeChildren();
			if(m_layer4)m_layer4.removeChildren();
			if(m_layer5)m_layer5.removeChildren();
			
			m_layer = null;
			m_layer2 = null;
			m_layer3 = null;
			if(m_layer4)m_layer4 = null;
			if(m_layer5)m_layer5 = null;
		}
		
		private function disposeChildren():void
		{
			for (var i:uint = 0; i < m_children.length; i++)
			{
				m_children[i] = null;
			}
			m_children = null;
		}
		
		private function disposeMaze():void
		{
			m_maze = null;
			for(var i:uint = 0; i<m_availableSpace.length; i++)
			{
				m_availableSpace[i] = null;
			}
			m_availableSpace = null;
		}
		
		private function disposeAvatar():void
		{
			m_robot = null;
			if(m_robot2) m_robot2 = null;
		}
		
		private function disposeBattery():void
		{
			m_battery = null;
			if(m_battery2) m_battery2 = null;
		}
		
		private function disposeHUD():void
		{
			m_hud.battery1Lvl = null;
			if(m_hud.battery2Lvl) m_hud.battery2Lvl = null;
			
			m_hud = null;
		}
		
		private function disposeSharedObj():void
		{
			m_SharedObjPlayers = null;
			m_win = null;
		}
		
		private function disposePowerUps():void
		{
			m_powerUp = null;
			m_powerUp2 = null;
		}
		
		private function disposeEffects():void
		{
			m_flickr = null;
		}
		
		private function disposeInstructions():void
		{
			m_instructions = null;
		}
	}
}