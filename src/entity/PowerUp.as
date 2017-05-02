package entity
{
	public class PowerUp extends Entity
	{
		public var power:Boolean = false;
		public var powerupX:int;
		
		public function PowerUp()
		{
			trace("init powerup");
			super();
			initSkin();
			placePowerUp();
		}
		
		private function initSkin():void
		{
			_skin = new BombRefill_mc();
			
			this.addChild(_skin);
		}
		
		public function placePowerUp():void
		{
			super.place(_skin);
			powerupX = _skin.x;
		}
	}
}