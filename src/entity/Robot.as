package entity
{
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;

	public class Robot extends DisplayStateLayerSprite
	{
		private var m_controls:EvertronControls = new EvertronControls();
		private var m_skin:Avatar;
		private var speed:int = 100;
		
		public var hit:Boolean;
				
		public function Robot()
		{
			//super.init();
			
		}
		
		override public function init():void
		{
			initSkin();
			trace("HHHHH");
		}
		
		override public function update():void
		{
			updateControls()
		}
		
		private function updateControls():void
		{
			if(Input.keyboard.justPressed(m_controls.PLAYER_LEFT)) this.moveLeft();
			else if(Input.keyboard.justPressed(m_controls.PLAYER_RIGHT)) this.moveRight();
			else if(Input.keyboard.justPressed(m_controls.PLAYER_DOWN)) this.moveDown();
			else if(Input.keyboard.justPressed(m_controls.PLAYER_UP)) this.moveUp();
		}
		
		private function moveUp():void
		{
			 this.y -= speed;
		}
		
		private function moveDown():void
		{
			this.y += speed;
		}
		
		private function moveLeft():void
		{
			this.x -= speed;
		}
		
		private function moveRight():void
		{
			this.x += speed;
		}
		
		private function initSkin():void
		{
			m_skin = new Avatar();
			
			//this.x = 100;
			//this.y = 100;
			
			this.addChild(m_skin);
			trace("this: " + this.x, this.y);
			trace("m_skin: " + m_skin.x, m_skin.y);
			trace(this);
		}

	}
}