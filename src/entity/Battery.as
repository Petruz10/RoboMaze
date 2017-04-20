package entity
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;

	//------------------------------------------------------------------------
	// Public class Battery
	//------------------------------------------------------------------------
	public class Battery extends Entity
	{
		//------------------------------------------------------------------------
		// public properties 
		//------------------------------------------------------------------------
		public var HP:int = 100;
		
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		private var m_timer:Timer;
		
		public function Battery()
		{
			super();
			trace("battery konstruktor");
			HPtimer();
		}
		
		//------------------------------------------------------------------------
		// private methods 
		//------------------------------------------------------------------------
		private function HPtimer():void
		{
			m_timer = Session.timer.create(500, removeHP);
		}
		
		//------------------------------------------------------------------------
		// public methods 
		//------------------------------------------------------------------------
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
		
		override public function dispose():void
		{
			disposeTimer();
		}
		
		private function disposeTimer():void
		{
			m_timer = null;
		}
	}
}