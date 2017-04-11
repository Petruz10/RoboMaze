package entity
{
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;

	public class Robot extends Entity
	{
		private var m_controls:EvertronControls = new EvertronControls();
		private var m_skin:MovieClip;
		private var m_layer:DisplayStateLayer;
		
		public function Robot()
		{
			
		}
		
		override public function init():void
		{
			initSkin();
		}
		
		override public function update():void
		{
			//super.update();
			updateControls();
		}
		
		private function updateControls():void
		{
			if(Input.keyboard.pressed(m_controls.PLAYER_LEFT)) this.moveLeft();
			else if(Input.keyboard.pressed(m_controls.PLAYER_RIGHT)) this.moveRight();
			else if(Input.keyboard.pressed(m_controls.PLAYER_DOWN)) this.moveDown();
			else if(Input.keyboard.pressed(m_controls.PLAYER_UP)) this.moveUp();
		}
		
		private function moveUp():void
		{
			
		}
		
		private function moveDown():void
		{
			
		}
		
		private function moveLeft():void
		{
			
		}
		
		private function moveRight():void
		{
			
		}
		
		private function initSkin():void
		{
			m_skin = new Avatar();
			
			m_skin.x = 200;
			m_skin.y = 300;
			trace(m_skin);
			addChild(m_skin);
			trace("initSkin Robot m. addChild");
		}
	}
}