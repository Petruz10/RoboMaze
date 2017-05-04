package entity
{
	public class Obstacle extends Entity
	{
		public function Obstacle(x:int)
		{
			super();
			initSkin(x);
		}
		
		private function initSkin(x:int):void
		{
			switch(x) 
			{
				case 0: 
					_skin = new Bomb_mc();
					break;
				case 1:
					_skin = new Wrong_mc();
					break;
			}
		
			this.addChild(_skin);
		}
	}
}