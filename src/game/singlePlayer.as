package game
{
	import entity.Robot;
	
	import state.Game;

	public class Singleplayer extends Game
	{
		private var m_robot:Robot;
		
		public function Singleplayer()
		{
			//super.addMaze(1);
		//	trace("hej hej");
			avatar();
		}
		
		private function avatar():void
		{
			m_robot = new Robot();
			trace("avatar");
			//addChild(m_robot);
		}
	}
}