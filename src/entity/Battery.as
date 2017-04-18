package entity
{
	import se.lnu.stickossdk.timer.Timer;

	public class Battery extends Entity
	{
		private var HP:int = 100;
		
		private var m_timer:Timer;
		
		public function Battery(x:int, y:int)
		{
			super();
		}
		
		override public function init():void
		{
			timer();
		}
		
		override public function update():void
		{
			
		}
		
		private function timer():void
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
				timer();
			}
			else trace("dead");
		}
		
		
	}
}