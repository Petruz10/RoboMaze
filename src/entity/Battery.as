package entity
{
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;

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
			m_timer = Session.timer.create(1000, removeHP);
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