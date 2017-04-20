package entity
{
	public class BatteryRefill extends Entity
	{
		public var batteryX:int;
		
		public function BatteryRefill()
		{
			super();
			initSkin();
			trace("BatteryRefill Constructor")
		}
		
		private function initSkin():void
		{
			_skin = new BatteryRefill_mc();
			super.place(_skin);
			
			trace("Battery refill x",_skin.x);
			batteryX = _skin.x;
			trace("batteryx var", batteryX);
			this.addChild(_skin);
		}
		
		public function placeBattery():void
		{
			super.place(_skin);
		}
	}
}