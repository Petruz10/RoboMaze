package entity
{
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;

	public class Robot extends Entity
	{
		private var m_controls:EvertronControls = new EvertronControls();
		private var m_skin:MovieClip;
		
		public function Robot()
		{
			super();
			//super.update();
			trace("robot");
		}
		
		override public function init():void
		{
			initSkin();
		}
		
		override public function update():void
		{
			if(Input.keyboard.pressed(m_controls.PLAYER_LEFT)) this.moveLeft();
			else if(Input.keyboard.pressed(m_controls.PLAYER_RIGHT)) this.moveRight();
			else if(Input.keyboard.pressed(m_controls.PLAYER_DOWN)) this.moveDown();
			else if(Input.keyboard.pressed(m_controls.PLAYER_UP)) this.moveUp();
		}
		
		private function moveUp():void
		{
			m_skin.y--;
		}
		
		private function moveDown():void
		{
			m_skin.y++;
		}
		
		private function moveLeft():void
		{
			m_skin.x--;
		}
		
		private function moveRight():void
		{
			m_skin.x ++;
		}
		
		private function initSkin():void
		{
			m_skin = new Avatar();
			
			m_skin.x = 100;
			m_skin.y = 100;
			
			addChild(m_skin);
			
		}

	}
}