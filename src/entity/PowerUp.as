package entity
{
	//------------------------------------------------------------------------
	// Public class PowerUp
	//------------------------------------------------------------------------
	public class PowerUp extends Entity
	{
		//------------------------------------------------------------------------
		// public properties 
		//------------------------------------------------------------------------
		public var type:int;
		
		public function PowerUp(x:int)
		{
			super();
			initSkin(x);
		}
		
		//------------------------------------------------------------------------
		// private methods 
		//------------------------------------------------------------------------
		/*
		* init the skin of the powerup
		*/
		private function initSkin(x:int):void
		{
			switch(x) 
			{
				case 0: 
					_skin = new BombRefill_mc();
					type = 0;
					break;
				
				case 1:
					_skin = new WrongRefill_mc();
					type = 1;
					break;
			}

			this.addChild(_skin);
		}
		
		//------------------------------------------------------------------------
		// public methods 
		//------------------------------------------------------------------------	
		public function placePowerup2(x:int, y:int):void
		{
			_skin.x = x;
			_skin.y = y;
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
			_skin = null;
		}
	}
}