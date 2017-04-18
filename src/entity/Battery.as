package entity
{
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	import se.lnu.stickossdk.timer.Timers;

	public class Battery extends Entity
	{
		public var HP:int = 100;
		
		private var m_timer:Timer;
		
		public function Battery()
		{
			//super();
			trace("battery konstruktor");
			HPtimer();
		}
		
		private function HPtimer():void
		{
			m_timer = Session.timer.create(100, removeHP);
		}
		
		public function getHP():void
		{
			
		}
		
		public function addHP():void
		{
			
		}
		
		public function removeHP():void
		{
			if(HP != 0) 
			{
				HP--;
				HPtimer();
				trace(HP);
			}
			else trace("dead");
		}
		
		
	}
}