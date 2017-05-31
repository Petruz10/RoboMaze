
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
		/**
		* some variables for the different layers
		*/
		private var m_layer:DisplayStateLayer;
		private var m_layer2:DisplayStateLayer;
		private var m_layer3:DisplayStateLayer;
		private var m_layer5:DisplayStateLayer;
		
		/**
		* the grapichal batteries
		*/
		private var m_battery:BatteryRefill;
		private var m_battery2:BatteryRefill;
		
		private var m_children:Vector.<Tile> = new Vector.<Tile>(); 
		private var m_players:int;
	
		private var m_backgroundMusic:SoundObject;
		private var m_bombSound:SoundObject;
		private var m_wrongSound:SoundObject;
		private var m_powerupSound:SoundObject;

		private var m_SharedObjPlayers:SharedObject;
		private var m_win:SharedObject;
		
		private var m_instructions:Instruction;
		private var startGame:Boolean = false;
						
		private var xArray:Vector.<int> = new Vector.<int>(); 
		private var yArray:Vector.<int> = new Vector.<int>(); 
		private var m_testObj:TestPlaceObj;
		
		//------------------------------------------------------------------------
		// protected properties 
		//------------------------------------------------------------------------
		protected var m_robotInt:int;
		
		protected var timerFunc:Function;
		protected var initTimerfunc:Function;
		protected var addChildPowerupFunc:Function;
		protected var placePowerupFunc:Function;
		protected var highscore:Function;
		
		protected var score:Number;
		protected var m_flickr:Flicker;
		protected var m_availableSpace:Vector.<Point> = new Vector.<Point>(); 
		
		protected var m_layer4:DisplayStateLayer;
		protected var m_hud;
	
		protected var m_maze:Maze;

		protected var m_robot:Robot;
		protected var m_robot2:Robot;
	
		protected var whichPower:Number;
				
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
		/**
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
		
		/**
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
			hitBatteryScreen();
			updateHUDBattery();
		}
		
		/**
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
			disposePlaceObj();
			disposeFunctions();
		}
		
		//------------------------------------------------------------------------
		// private methods
		//------------------------------------------------------------------------
		/**
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
		
		/**
		* function to save in sharedobject if there is one or two players playing
		*/
		private function initSharedObject():void
		{
			m_SharedObjPlayers = SharedObject.getLocal("players");
			m_SharedObjPlayers.data.players = m_players;
			m_SharedObjPlayers.flush();
	
			return;
		}
		/**
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
		
		/**
		* function to get all the childrens in the maze, aka walls
		*/
		private function getChildren():void
		{
			for (var i:uint = 0; i < m_maze.numChildren; i++)
			{
				m_children.push(m_maze.getChildAt(i));
			}
		}
		
		/**
		* instance the new testobject and add it to the stage, 
		* the object that tests if there are any spots
		*/
		private function initTestObj():void
		{
			m_testObj = new TestPlaceObj();
			m_testObj.placeObj();
			
			m_layer.addChild(m_testObj);
		}
		
		/**
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
		
		/**
		* function to check the length of the Vector of available spaces
		*/
		private function checkLength():void
		{
			if(m_availableSpace.length < 60) findPoints();
		}
		
		/**
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
					Session.timer.create(1600, addChildPowerupFunc);
					Session.timer.create(500, placePowerupFunc);
					break;
				
				case 1:
					initTimerfunc();
			}
			
			findBatteryPlace();
		}
		
		/**
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
		
		/**
		* function to play the background sound
		*/
		private function initSound():void
		{
			Session.sound.musicChannel.sources.add("game_bgmusic", BackgroundGame_mp3);
			m_backgroundMusic = Session.sound.musicChannel.get("game_bgmusic");
			m_backgroundMusic.volume = 0.3;
			m_backgroundMusic.play(int.MAX_VALUE); //loop av ljud "Henke hack"
		}
		
		/**
		* function to instance a new grapichal battery
		*/
		private function initBattery():void
		{
			m_battery = new BatteryRefill();
		}
		
		/**
		* function to instance a new grapichal battery
		*/
		private function initBattery2():void
		{
			m_battery2 = new BatteryRefill();
		}
		
		/**
		* function to add the battery/batteries to tha stage
		*/
		private function addBattery():void
		{
			m_layer3.addChild(m_battery);
			if(m_battery2) m_layer3.addChild(m_battery2);
		}
		
		/**
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
		
		/**
		* function to see if anyone gets a battery
		*/
		private function hitBatteryScreen():void
		{
			switch(m_players)
			{
				case 2:
					if(m_battery.hitTestObject(m_robot2.area)) m_robot2.hitBattery = true;
					if(m_battery2.hitTestObject(m_robot.area)) m_robot.hitBattery = true;
					
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
		
		/**
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
		
		/**
		* function to play a bomb sound
		*/
		private function initBombSound():void
		{
			Session.sound.musicChannel.sources.add("game_bombSound", RobotBomb_mp3);
			m_bombSound = Session.sound.musicChannel.get("game_bombSound");
			m_bombSound.volume = 0.2;
			m_bombSound.play();
		}

		//------------------------------------------------------------------------
		// protected methods
		//------------------------------------------------------------------------
		protected function bombEffect(robot):void
		{
			initBombSound();
			robot.speed = 0;
			
			m_flickr = new Flicker(robot.skin, 1000); //obj, tid (hur länge), intervall
			Session.effects.add(m_flickr);
			Session.timer.create(1000, initSpeed);
		}
		
		/**
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
				if(m_robot.battery.HP > 0) initTimerfunc();		
				if(m_robot.battery.HP == 0) 
				{
					m_robot.die = true;
					highscore();
				}
				m_win.data.won = 0;
			}
			m_win.flush(); 
		}
		
		protected function initPowerupSound():void
		{
			Session.sound.musicChannel.sources.add("powerup_sound", RobotPickUp_mp3);
			m_powerupSound = Session.sound.musicChannel.get("powerup_sound");
			m_powerupSound.volume = 0.3;
			m_powerupSound.play();
		}
		
		protected function initWrongWaySound():void
		{
			Session.sound.musicChannel.sources.add("game_wrongSound", RobotWrongWay_mp3);
			m_wrongSound = Session.sound.musicChannel.get("game_wrongSound");
			m_wrongSound.volume = 0.5;
			m_wrongSound.play();
		}
		
		/**
		* function to set the speed of the robot to normal
		*/
		protected function initSpeed():void
		{
			if(m_robot2) m_robot2.speed = 3;
			m_robot.speed = 3;
		}
		
		/**
		* function to change the display state to GameOver
		*/
		protected function initGameOver():void
		{
			Session.application.displayState = new GameOver;
		}
		
		/**
		* function to get the maze
		*/
		protected function addMaze(maze:Maze):void
		{	
			m_maze = maze;
			getChildren();
		}
		
		/**
		* function to get the first avatar
		*/
		protected function addAvatar(robot:Robot):void
		{
			m_robot = robot;
		}
		
		/**
		* function to get the second avatar
		*/
		protected function addMultiplayer(robot:Robot):void
		{
			m_robot2 = robot;
		}
		
		/**
		* function to get the HUD
		*/
		protected function addHUD(hud):void
		{
			m_hud = hud;
		}
		
		//------------------------------------------------------------------------
		// dispose methods
		//------------------------------------------------------------------------
		private function disposePlaceObj():void
		{
			for(var i:uint = 0; i<xArray.length; i++)
			{
				xArray[i] = null;
			}
			
			for( var j:uint = 0; i<yArray.length; i++)
			{
				yArray[i] = null;
			}
			
			xArray = null;
			yArray = null;
			m_testObj = null;
		}
		
		private function disposeFunctions():void
		{
			timerFunc = null;
			initTimerfunc = null;
			addChildPowerupFunc = null;
			placePowerupFunc = null;
			highscore = null;
		}
		
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
			trace("disposeMaze");
			m_maze.dispose();
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
			m_hud = null;
		}
		
		private function disposeSharedObj():void
		{
			m_SharedObjPlayers = null;
			m_win = null;
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