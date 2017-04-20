package entity
{
	public class BatteryRefill extends Entity
	{
		private var m_skin:BatteryRefill_mc;
		
		public function BatteryRefill()
		{
			super();
			initSkin();
			trace("BatteryRefill Constructor")
		}
		
		private function initSkin():void
		{
			m_skin = new BatteryRefill_mc();
			super.place(m_skin);
			
			//trace("Battery refill x", m_skin.x);
			this.addChild(m_skin);
		}
		
		public function placeBattery():void
		{
			super.place(m_skin);
		}
	}
}