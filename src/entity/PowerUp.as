package entity
{
	import flash.display.Sprite;

	public class PowerUp extends Entity
	{
		public var powerupX:int;
		public var powerupY:int;
		private var container:Sprite = new Sprite();
		
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
			container.graphics.drawRect(0, 0, 35, 35);
			
			container.addChild(_skin);
			this.addChild(container);
		}
		
		public function placePowerUp():void
		{
			super.place(container);
			powerupX = container.x;
			powerupY = container.y;
		}
		
		public function placePowerup2(x:int, y:int):void
		{
			container.x = x;
			container.y = y;
		}
	}
}