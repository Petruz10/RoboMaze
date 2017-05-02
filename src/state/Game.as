package state
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import flash.net.SharedObject;
	
	import component.Maze;
	
	import entity.BatteryRefill;
	import entity.PowerUp;
	import entity.Robot;
	import entity.Tile;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.fx.Flicker;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;


	//------------------------------------------------------------------------
	// Public class Game
	//------------------------------------------------------------------------
	public class Game extends DisplayState
	{
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		private var m_layer:DisplayStateLayer;
		private var m_layer2:DisplayStateLayer;
		private var m_layer3:DisplayStateLayer;
		private var m_layer4:DisplayStateLayer;
		
		private var m_powerUp:PowerUp;
		
		private var m_robot:Robot;
		private var m_robot2:Robot;
		
		private var m_maze:Maze;
		private var m_maze2:Maze;
		
		private var m_battery:BatteryRefill;
		private var m_battery2:BatteryRefill;
		
		private var children:Vector.<Tile> = new Vector.<Tile>(); 
		
		private var m_players:int;
		
		private var m_hud;
		
		private var m_gameTime:Number = 0;
		private var m_time:String;
		
		private var min:int = 0;
		private var sek:Number = 0;
		
		private var m_score:Number = 0;
				
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
		override public function init():void
		{
			initLayers();
			initBattery();
			if(m_players == 2) 
			{
				initBattery2();
				addChildPowerUp();
			}
			initSharedObject();
			initTimer();
		}
		
		override public function update():void
		{
			placeBattery();
			hitTest();
			hitBattery();
			updateHUDBattery();
			updateHUDTime();
			
			if(m_players == 2) 
			{
				placePowerup();
				hitPowerup();
			}
			
			if(m_robot.obstacle || m_robot2.obstacle) checkhitObstacle();
		}
		
		override public function dispose():void
		{
			disposeMaze();
			disposeAvatar();
			disposeChildren();
			disposeLayers();	
			disposeBattery()
			disposeHUD();
		}
		
		//------------------------------------------------------------------------
		// private methods
		//------------------------------------------------------------------------
		private function initSharedObject():void
		{
			var players:SharedObject;
			
			players = SharedObject.getLocal("players");
			players.data.players = 	m_players;
			players.flush();
			
			trace("sharedObj", players.data.players);
			return;
		}
		
		private function initTimer():void
		{
			var timer:Timer = Session.timer.create(1, updateTimer);
		}
		
		private function updateTimer():void
		{
			checkBattery();
			
			var hundraSek:Number;
			
			m_score += 1.666666666666667;
			
			m_gameTime += 1.666666666666667;
			hundraSek = Math.floor(m_gameTime);
			
			if(hundraSek == 98)
			{
				sek++; 
				m_gameTime = 0;
				if(sek == 60)
				{
					sek = 0;
					min ++;
				}
			}
			
			m_time = min+":"+ sek + ":" + hundraSek;
		}
		
		private function checkBattery():void
		{
			if (m_players == 2) 
			{
				if(m_robot2.battery.HP > 0 && m_robot.battery.HP > 0) initTimer();	
				
				if(m_robot.battery.HP <= 0 || m_robot2.battery.HP <= 0) 
				{
					Session.timer.create(1000, initGameOver);
				}
			}
			else
			{
				if(m_robot.battery.HP > 0) initTimer();	
				
				if(m_robot.battery.HP == 0) initHighScore();
			}
		}
		
		private function initHighScore():void
		{
			var table:int = 1;
			var score:int = m_score;
			var range:int = 10;
			
			Session.highscore.smartSend(table, score, range, gameOver);
		}
		
		private function gameOver(e):void
		{
			//trace("a", e);
			Session.timer.create(1000, initGameOver);
		}
		
		private function initGameOver():void
		{
			trace("game over state");
			Session.application.displayState = new GameOver;
		}
		
		private function initBattery():void
		{
			m_battery = new BatteryRefill();
			addBattery();
			m_battery.placeBattery();
		}
		
		private function initBattery2():void
		{
			m_battery2 = new BatteryRefill();
			addBattery();
		}
		
		private function placeBattery():void
		{
			
			for (var i:int = 0; i<children.length; i++)
			{
				if(m_players == 2)
				{
					if(m_battery.hitTestObject(children[i]) || m_battery.batteryX <= 400) m_battery.placeBattery();
				}
				else
				{
					if(m_battery.hitTestObject(children[i])) m_battery.placeBattery(); 
				}
			}
			
			if(m_players == 2) m_battery2.placeBattery2(m_battery.batteryX - 400,  m_battery.batteryY);
		}
		
		private function placePowerup():void
		{
			for (var i:int = 0; i<children.length; i++)
			{
				if(m_powerUp.hitTestObject(children[i])) m_powerUp.placePowerUp(); 
			}
		}
		
		private function initLayers():void
		{	
			m_layer = layers.add("maze layer");
			m_layer2 = layers.add("robot layer");
			m_layer3 = layers.add("battery layer");
			m_layer4 = layers.add("powerup");
			
			if(m_maze) m_layer.addChild(m_maze);
			if(m_maze2) m_layer.addChild(m_maze2);
			
			if(m_robot) m_layer2.addChild(m_robot);	
			if(m_robot2) m_layer2.addChild(m_robot2);
			
			m_layer.addChild(m_hud);
		}
		
		private function addChildPowerUp():void
		{
			if(m_powerUp) m_layer4.addChild(m_powerUp);
		}
		
		private function addBattery():void
		{
			m_layer3.addChild(m_battery);
			if(m_battery2) m_layer3.addChild(m_battery2);
		}
		
		private function getChildren():void
		{
			for (var i:uint = 0; i < m_maze.numChildren; i++)
			{
				children.push(m_maze.getChildAt(i));
			}
			
			if(m_maze2)
			{
				for (var j:uint = 0; j < m_maze2.numChildren; j++)
				{
					children.push(m_maze2.getChildAt(j));
				}
			}
		}
		
		private function hitTest():void
		{	
			
			for (var i:int = 0; i<children.length; i++)
			{
				if(children[i].hitTestObject(m_robot.area)) m_robot.hit = true;
				if(m_robot2)
				{
					if(children[i].hitTestObject(m_robot2.area)) m_robot2.hit = true;
				}
			}
		}
		
		private function hitBattery():void
		{
			if(m_players == 2)
			{	
				if(m_battery.hitTestObject(m_robot2.area)) m_robot2.hitBattery = true;
				if(m_battery2.hitTestObject(m_robot.area)) m_robot.hitBattery = true;
				
				if(m_robot.hitBattery  || m_robot2.hitBattery)
				{
					m_layer3.removeChildren();
					m_battery.placeBattery();
					addBattery();
					return;
				}
			}
			
			else
			{
				if(m_battery.hitTestObject(m_robot.area))
				{
					m_robot.hitBattery = true;
					m_layer3.removeChild(m_battery);
					m_battery.placeBattery();
					addBattery();
					return;
				}
			}
		}
		
		private function hitPowerup():void
		{
			if(m_powerUp.hitTestObject(m_robot2.area)) 
			{
				m_robot2.powerUp ++;
				m_layer4.removeChild(m_powerUp);
			}
			if(m_powerUp.hitTestObject(m_robot.area)) 
			{
				m_robot.powerUp ++;
				m_layer4.removeChild(m_powerUp);
			}
		//	trace("powerup antal", m_robot.powerUp, m_robot2.powerUp);
		}
		
		private function updateHUDBattery():void
		{
			m_hud.battery1Lvl = m_robot.battery.HP;
			if(m_players == 2) m_hud.battery2Lvl = m_robot2.battery.HP;
		}
		
		private function updateHUDTime():void
		{
			m_hud.time = m_time;
		}
		
		
		private function checkhitObstacle():void
		{
			var flickr:Flicker;
			
			if(m_robot2.obstacle) 
			{
				if(m_robot.hitTestObject(m_robot2.obstacle))
				{
					trace("hit obsticle");
					m_robot.speed = 0;
					m_robot2.removeChild(m_robot2.obstacle);// = null;
					flickr = new Flicker(m_robot, 1000, 20); //obj, tid (hur länge), intervall
					Session.effects.add(flickr);
					Session.timer.create(600, initSpeed);
				}
			}
			if(m_robot.obstacle)
			{
				if(m_robot2.hitTestObject(m_robot.obstacle)) 
				{
					trace ("hit");
					m_robot2.speed = 0;
					m_robot.removeChild(m_robot.obstacle); // = null;
					flickr = new Flicker(m_robot2, 1000, 20); //obj, tid (hur länge), intervall
					Session.effects.add(flickr);
					Session.timer.create(600, initSpeed);
				}
			}
		}
		
		private function initSpeed():void
		{
			m_robot2.speed = 3;
			m_robot.speed = 3;
			Session.timer.create(8600, addChildPowerUp);
			Session.timer.create(8600, placePowerup);
		}
			

		//------------------------------------------------------------------------
		// protected methods
		//------------------------------------------------------------------------
		protected function addMaze(maze:Maze):void
		{	
			m_maze = maze;
			getChildren();
		}
		
		protected function addMaze2(maze:Maze):void
		{	
			m_maze2 = maze;			
		}
			
		protected function addAvatar(Avatar:Robot):void
		{
			m_robot = Avatar;
		}
		
		protected function addMultiplayer(robot:Robot):void
		{
			m_robot2 = robot;
		}
		
		protected function addHUD(hud):void
		{
			m_hud = hud;
		}
		
		protected function addPowerUp(x):void
		{
			m_powerUp = x;
			
		}
		
		//------------------------------------------------------------------------
		// dispose methods
		//------------------------------------------------------------------------
		private function disposeLayers():void
		{
			m_layer.removeChildren();
			m_layer2.removeChildren();
			m_layer3.removeChildren();
			
			m_layer = null;
			m_layer2 = null;
			m_layer3 = null;
		}
		
		private function disposeChildren():void
		{
			for (var i:uint = 0; i < children.length; i++)
			{
				children[i] = null;
			}
			children = null;
		}
		
		private function disposeMaze():void
		{
			m_maze = null;
			if(m_maze2) m_maze2 = null;
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
	}
}