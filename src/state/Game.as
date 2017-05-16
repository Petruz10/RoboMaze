
package state
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import flash.geom.Point;
	import flash.net.SharedObject;
	
	import component.Instruction;
	import component.Maze;
	import component.MultiplayerInstruction;
	import component.SingleplayerInstruction;
	
	import entity.BatteryRefill;
	import entity.PowerUp;
	import entity.Robot;
	import entity.TestPlaceObj;
	import entity.Tile;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.fx.Flicker;
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
		
		private var m_gameTime:Number = 0;
		private var m_time:String;
		
		private var m_min:int = 0;
		private var m_sek:Number = 0;
		private var m_score:Number = 0;
		
		private var m_backgroundMusic:SoundObject;
		private var m_bombSound:SoundObject;
		
		private var m_SharedObjPlayers:SharedObject;
		private var m_win:SharedObject;
		
		private var m_flickr:Flicker;
		private var m_instructions:Instruction;
		
		private var startGame:Boolean= false;
						
		private var m_availableSpace:Vector.<Point> = new Vector.<Point>(); 
		private var xArray:Vector.<int> = new Vector.<int>(); 
		private var yArray:Vector.<int> = new Vector.<int>(); 
		private var m_testObj:TestPlaceObj;
		
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
			
			if(m_players == 2) 
			{
				hitPowerup();
				checkBattery();
				updateHUDPowerup();
				if(m_robot.obstacle || m_robot2.obstacle) checkhitObstacle();
			}
			else updateHUDTime();
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
			
			if(m_players == 2) 
			{
				m_robot2.initBattery();
				initBattery2();
				Session.timer.create(1600, addChildPowerUp);
				Session.timer.create(500, placePowerup);
			}
			else
			{
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
			Session.timer.create(1, updateTimer);
		}
		
		/*
		* function to play the background sound
		*/
		private function initSound():void
		{
			Session.sound.musicChannel.sources.add("game_bgmusic", BackgroundGame_mp3);
			m_backgroundMusic = Session.sound.musicChannel.get("game_bgmusic");
			m_backgroundMusic.volume = 0.4;
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
		
		/*
		* function to update the timer and make it into real time,
		* also sends the info to HUD
		*/
		private function updateTimer():void
		{
			checkBattery();
			
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
		* function to see the battery level at the players,
		* and if there is none left save who won in sharedObj
		*/
		private function checkBattery():void
		{
			m_win = SharedObject.getLocal("playerwon");
			
			if (m_players == 2) 
			{
				
				if(m_robot.battery.HP == 0)
				{
					Session.timer.create(1000, initGameOver);
					m_win.data.won = 2;
				}
				if(m_robot2.battery.HP == 0)
				{
					Session.timer.create(1000, initGameOver);
					m_win.data.won = 1;
				}
			}
			else
			{
				if(m_robot.battery.HP > 0) initTimer();		
				if(m_robot.battery.HP == 0) initHighScore();
				m_win.data.won = 0;
			}
			
			m_win.flush(); 
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
			m_layer4 = layers.add("powerup layer");

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
			if(m_players == 2)
			{	
				if(m_battery.hitTestObject(m_robot2)) m_robot2.hitBattery = true;
				if(m_battery2.hitTestObject(m_robot)) m_robot.hitBattery = true;
				
				if(m_robot.hitBattery  || m_robot2.hitBattery)
				{
					m_layer3.removeChildren();
					findBatteryPlace();
					return;
				}
			}
			
			else
			{
				if(m_battery.hitTestObject(m_robot.area))
				{
					m_robot.hitBattery = true;
					m_layer3.removeChildren();
					findBatteryPlace();
					return;
				}
			}
		}
		
		/*
		* function to check if anyone gets a powerup
		*/
		private function hitPowerup():void
		{
			
			if(m_powerUp.hitTestObject(m_robot2.area)) m_robot2.powerUp ++;
			if(m_powerUp2.hitTestObject(m_robot.area)) m_robot.powerUp ++;
			
			if(m_powerUp.hitTestObject(m_robot2.area) || m_powerUp2.hitTestObject(m_robot.area))
			{
				if(m_layer4)m_layer4.removeChildren();
			}
		}
		
		/*
		* function to update the battery in the HUD
		*/
		private function updateHUDBattery():void
		{
			m_hud.battery1Lvl = m_robot.battery.HP;
			if(m_players == 2) m_hud.battery2Lvl = m_robot2.battery.HP;
		}
		
		/*
		* function to update the time in HUD
		*/
		private function updateHUDTime():void
		{
			m_hud.time = m_time;
		}
		
		/*
		* function to update the powerups in HUD
		*/
		private function updateHUDPowerup():void
		{
			switch(whichPower)
			{
				case 0:
					if(m_robot.powerUp == 1) m_hud.bomb = 1;
					else if(m_robot2.powerUp == 1) m_hud.bomb = 2;
					else m_hud.bomb = 0;
					break;
				
				case 1:
					if(m_robot.powerUp == 1) m_hud.wrong = 1;
					else if(m_robot2.powerUp == 1) m_hud.wrong = 2;
					else m_hud.wrong = 0;
					break;
			}
			
		}
		
		/*
		* function to see if a robot walks into a obstacle "sabotage grejs"
		*/
		private function checkhitObstacle():void
		{
			if(m_robot2.obstacle) 
			{
				if(m_robot.hitTestObject(m_robot2.obstacle))
				{
					initBombSound();
					m_robot2.removeChild(m_robot2.obstacle);
					
					switch(whichPower)
					{
						case 0:
							m_robot.speed = 0;
							m_flickr = new Flicker(m_robot, 1000); //obj, tid (hur länge), intervall
							Session.effects.add(m_flickr);
							Session.timer.create(600, initSpeed);
							break;
						
						case 1:
							m_robot.wrongSide = true;
							Session.timer.create(7600, setToFalse);
							break;
					}
					
				}
			}
			
			if(m_robot.obstacle)
			{
				if(m_robot2.hitTestObject(m_robot.obstacle)) 
				{
					initBombSound();
					m_robot.removeChild(m_robot.obstacle);
					switch(whichPower)
					{
						case 0:
							m_robot2.speed = 0;
							m_flickr = new Flicker(m_robot2, 1000); //obj, tid (hur länge), intervall
							Session.effects.add(m_flickr);
							Session.timer.create(600, initSpeed);
							break;
						
						case 1:
							m_robot2.wrongSide = true;
							Session.timer.create(4600, setToFalse);
							break;
					}
				}
			}
		}
		
		/*
		* function to play a bomb sound
		*/
		private function initBombSound():void
		{
			trace("bomb ljud!!");
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
			m_robot2.speed = 3;
			m_robot.speed = 3;
			
			placePowerup();
			Session.timer.create(6000, addPowerUp);
			Session.timer.create(8600, addChildPowerUp);
		}
		
		/*
		* function to set the controls to normal
		*/
		private function setToFalse():void
		{
			m_robot.wrongSide = false;
			m_robot2.wrongSide = false;
			
			placePowerup();
			Session.timer.create(6000, addPowerUp);
			Session.timer.create(8600, addChildPowerUp);
		}
		
		/*
		* function to init the highscore
		*/
		private function initHighScore():void
		{
			var table:int = 1;
			var score:int = m_score;
			var range:int = 10;
			
			Session.highscore.smartSend(table, score, range, gameOver);
		}
		
		/*
		* function to set a timer before the gameover screen shows
		*/
		private function gameOver(e):void
		{
			Session.timer.create(1000, initGameOver);
		}
		
		/*
		* function to change the display state to GameOver
		*/
		private function initGameOver():void
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

			
			m_robot.obstacleType = whichPower;
			m_robot2.obstacleType = whichPower;
			
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