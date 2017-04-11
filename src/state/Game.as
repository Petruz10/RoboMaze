package state
{
	import entity.Robot;
	
	import game.SinglePlayer;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;

	public class Game extends DisplayState
	{
		private var m_layer:DisplayStateLayer;
		//private var m_robot:Robot;
		private var m_testSinglePlayer:SinglePlayer;
		
		public function Game()
		{
			super();
			trace("game konstruktor");
		}
		
		override public function init():void
		{
			trace("game1");
			initLayers();
			m_testSinglePlayer = new SinglePlayer();
			
		}
		
		override public function update():void
		{
			
		}
		
		override public function dispose():void
		{
			
		}
		
		private function initLayers():void
		{
			m_layer = layers.add("bakground_test_layer");
			//m_robot = new Robot();
			
			m_layer.addChild(m_testSinglePlayer);
		}
		
		protected function addMaze(players:int):void
		{
			
		}
	}
}