package entity
{
	import flash.display.Shape;

	public class TestPlaceObj extends Entity
	{
		//------------------------------------------------------------------------
		// private properties
		//------------------------------------------------------------------------
		private var m_skin:Shape;
		
		//------------------------------------------------------------------------
		// public properties
		//------------------------------------------------------------------------
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
		/*
		* function to init the skin
		*/
		private function initSkin():void
		{
			m_skin = new Shape();
			//m_skin.graphics.beginFill(0xFF2200);
			m_skin.graphics.drawRect(0,0,36, 36);
			//m_skin.graphics.endFill();
			
			this.addChild(m_skin);
		}
		
		//------------------------------------------------------------------------
		// public methods
		//------------------------------------------------------------------------
		/*
		* function to place the object
		*/
		public function placeObj():void
		{
			super.place(m_skin);
			testObjX = m_skin.x;
			testObjY = m_skin.y;
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
			m_skin = null;
		}
	}
}