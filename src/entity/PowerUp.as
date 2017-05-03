package entity
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import flash.display.Sprite;

	//------------------------------------------------------------------------
	// Public class PowerUp
	//------------------------------------------------------------------------
	public class PowerUp extends Entity
	{
		//------------------------------------------------------------------------
		// public properties 
		//------------------------------------------------------------------------
		public var powerupX:int;
		public var powerupY:int;
		
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		private var m_container:Sprite = new Sprite();
		
		public function PowerUp()
		{
			trace("init powerup");
			super();
			initSkin();
			placePowerUp();
		}
		
		//------------------------------------------------------------------------
		// private methods 
		//------------------------------------------------------------------------
		private function initSkin():void
		{
			_skin = new BombRefill_mc();
			m_container.graphics.drawRect(0, 0, 35, 35);
			
			m_container.addChild(_skin);
			this.addChild(m_container);
		}
		
		//------------------------------------------------------------------------
		// public methods 
		//------------------------------------------------------------------------
		public function placePowerUp():void
		{
			super.place(m_container);
			powerupX = m_container.x;
			powerupY = m_container.y;
		}
		
		public function placePowerup2(x:int, y:int):void
		{
			m_container.x = x;
			m_container.y = y;
		}
		
		//------------------------------------------------------------------------
		// dispose methods 
		//------------------------------------------------------------------------
		override public function dispose():void
		{
			disposeContainer();
		}
		
		private function disposeContainer():void
		{
			m_container = null;
		}
	}
}