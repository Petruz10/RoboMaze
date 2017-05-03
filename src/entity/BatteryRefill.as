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
		
		//------------------------------------------------------------------------
		// private properties
		//------------------------------------------------------------------------
		private var m_container:Sprite = new Sprite();
		
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
			
			m_container.graphics.drawRect(0, 0, 35, 35);
			
			m_container.addChild(_skin);
			this.addChild(m_container);
		}
		
		//------------------------------------------------------------------------
		// public methods
		//------------------------------------------------------------------------
		public function placeBattery():void
		{
			super.place(m_container);
			batteryX = m_container.x;
			batteryY = m_container.y;
		}
		
		public function placeBattery2(x:int, y:int):void
		{
			m_container.x = x;
			m_container.y = y;
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
			m_container = null;
		}
	}
}