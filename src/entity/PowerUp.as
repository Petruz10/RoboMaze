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
		
		public function PowerUp(x:int)
		{
			trace("init powerup");
			super();
			initSkin(x);
			placePowerUp();
		}
		
		//------------------------------------------------------------------------
		// private methods 
		//------------------------------------------------------------------------
		private function initSkin(x:int):void
		{
			switch(x) 
			{
				case 0: 
					_skin = new BombRefill_mc();
					break;
				case 1:
					//_skin = new ikon för tvärtomstyrning;
					break;
			}
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
			_skin = null;
		}
	}
}