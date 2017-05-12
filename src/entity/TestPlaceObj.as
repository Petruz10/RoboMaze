package entity
{
	import flash.display.Shape;

	public class TestPlaceObj extends Entity
	{
		private var m_skin:Shape;
		
		public var testObjX:int;
		public var testObjY:int;
		
		public function TestPlaceObj()
		{
			super();
			initSkin();
		}
		
		//------------------------------------------------------------------------
		// private methods
		//------------------------------------------------------------------------
		private function initSkin():void
		{
			m_skin = new Shape();
			//m_skin.graphics.beginFill(0xFF2200);
			m_skin.graphics.drawRect(0,0,36, 36);
			m_skin.graphics.endFill();
			
		//	m_container.graphics.drawRect(0, 0, 35, 35);
			
			//m_container.addChild(_skin);
			this.addChild(m_skin);
		}
		
		//------------------------------------------------------------------------
		// public methods
		//------------------------------------------------------------------------
		public function placeBattery():void
		{
			super.place(m_skin);
			testObjX = m_skin.x;
			testObjY = m_skin.y;
		}
		
	/*	public function placeBattery2(x:int, y:int):void
		{
			m_container.x = x;
			m_container.y = y;
		}*/
		
		//------------------------------------------------------------------------
		// dispose methods
		//------------------------------------------------------------------------
		override public function dispose():void
		{
			disposeSkin();
		}
		
		private function disposeSkin():void
		{
			m_skin = null;
		}
	}
}