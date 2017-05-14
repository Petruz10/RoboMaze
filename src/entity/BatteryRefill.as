package entity
{
	//------------------------------------------------------------------------
	// public class BatteryRefill
	//------------------------------------------------------------------------
	public class BatteryRefill extends Entity
	{
		public function BatteryRefill()
		{
			super();
			initSkin();
		}
		
		//------------------------------------------------------------------------
		// private methods
		//------------------------------------------------------------------------
		private function initSkin():void
		{
			_skin = new BatteryRefill_mc();
	
			this.addChild(_skin);
		}
		
		//------------------------------------------------------------------------
		// public methods
		//------------------------------------------------------------------------
		public function placeBattery2(x:int, y:int):void
		{
			_skin.x = x;
			_skin.y = y;
		}
		
		//------------------------------------------------------------------------
		// dispose methods
		//------------------------------------------------------------------------
		override public function dispose():void
		{
			disposeSkin();
		}
		
		private function disposeSkin():void
		{
			_skin = null;
		}
	}
}