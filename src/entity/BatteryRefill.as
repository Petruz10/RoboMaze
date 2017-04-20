package entity
{
	public class BatteryRefill extends Entity
	{
		public var batteryX:int;
		public var batteryY:int;
		
		public function BatteryRefill()
		{
			super();
			initSkin();
			trace("BatteryRefill Constructor")
		}
		
		private function initSkin():void
		{
			_skin = new BatteryRefill_mc();
			
			this.addChild(_skin);
		}
		
		public function placeBattery():void
		{
			super.place(_skin);
			batteryX = _skin.x;
			batteryY = _skin.y;
		}
		
		public function placeBattery2(x:int, y:int):void
		{
			_skin.x = x;
			_skin.y = y;
		}
	}
}