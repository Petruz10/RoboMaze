package entity
{
	import flash.display.Sprite;

	//------------------------------------------------------------------------
	// public class BatteryRefill
	//------------------------------------------------------------------------
	public class BatteryRefill extends Entity
	{
		//------------------------------------------------------------------------
		// public properties
		//------------------------------------------------------------------------
		public var batteryX:int;
		public var batteryY:int;
		
		private var container:Sprite = new Sprite();
		
		public function BatteryRefill()
		{
			super();
			initSkin();
			trace("BatteryRefill Constructor")
		}
		
		//------------------------------------------------------------------------
		// private methods
		//------------------------------------------------------------------------
		private function initSkin():void
		{
			_skin = new BatteryRefill_mc();
			
			container.graphics.drawRect(0, 0, 35, 35);
			
			container.addChild(_skin);
			this.addChild(container);
		}
		
		//------------------------------------------------------------------------
		// public methods
		//------------------------------------------------------------------------
		public function placeBattery():void
		{
			super.place(container);
			batteryX = container.x;
			batteryY = container.y;
		}
		
		public function placeBattery2(x:int, y:int):void
		{
			container.x = x;
			container.y = y;
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