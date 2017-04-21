package state
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import component.Maze;
	
	import entity.BatteryRefill;
	import entity.Robot;
	import entity.Tile;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;

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
		
		private var m_robot:Robot;
		private var m_robot2:Robot;
		
		private var m_maze:Maze;
		private var m_maze2:Maze;
		
		private var m_battery:BatteryRefill;
		private var m_battery2:BatteryRefill;
		
		private var children:Vector.<Tile> = new Vector.<Tile>(); 
		
		private var m_players:int;
				
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
			if(m_players == 2) initBattery2();
	
		}
		
		override public function update():void
		{
			placeBattery();
			hitTest();
			hitBattery();
		}
		
		override public function dispose():void
		{
			disposeMaze();
			disposeAvatar();
			disposeChildren();
			disposeLayers();	
			disposeBattery()
		}
		
		//------------------------------------------------------------------------
		// private methods
		//------------------------------------------------------------------------
		private function initBattery():void
		{
			m_battery = new BatteryRefill();
			addBattery();
			m_battery.placeBattery();
		}
		
		private function initBattery2():void
		{
			m_battery2 = new BatteryRefill();
			addBattery2();
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
		
		private function initLayers():void
		{	
			m_layer = layers.add("maze layer");
			m_layer2 = layers.add("robot layer");
			m_layer3 = layers.add("battery layer");
			
			if(m_maze) m_layer.addChild(m_maze);
			if(m_maze2) m_layer.addChild(m_maze2);
			
			if(m_robot) m_layer2.addChild(m_robot);	
			if(m_robot2) m_layer2.addChild(m_robot2);
		}
		
		private function addBattery():void
		{
			m_battery.opaqueBackground = 0xFFFFFF;
			m_layer3.addChild(m_battery);
		}
		
		private function addBattery2():void
		{	
			m_layer3.addChild(m_battery2);
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
				if(m_robot.hitTestObject(children[i])) m_robot.hit = true;
				if(m_robot2)
				{
					if(m_robot2.hitTestObject(children[i])) m_robot2.hit = true;
				}
			}
		}
		
		private function hitBattery():void
		{
			if(m_players == 2)
			{	
				if(m_robot2.hitTestObject(m_battery)) m_robot2.hitBattery = true;
				if(m_robot.hitTestObject(m_battery2)) m_robot.hitBattery = true;
				
				if(m_robot.hitBattery  || m_robot2.hitBattery)
				{
					m_layer3.removeChildren();
					m_battery.placeBattery();
					addBattery();
					addBattery2();
					return;
				}
			}
			
			else
			{
				if(m_robot.hitTestObject(m_battery))
				{
					m_robot.hitBattery = true;
					m_layer3.removeChild(m_battery);
					m_battery.placeBattery();
					addBattery();
					return;
				}
			}
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
	}
}